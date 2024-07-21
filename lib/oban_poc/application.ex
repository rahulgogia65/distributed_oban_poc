defmodule ObanPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ObanPoc.Worker.start_link(arg)
      # {ObanPoc.Worker, arg}
      ObanPoc.Repo,
      {Oban, Application.fetch_env!(:oban_poc, Oban)},
      {Cluster.Supervisor, [topologies(), [name: ObanPoc.ClusterSupervisor]]},
      {Horde.Registry, [name: ObanPoc.HordeRegistry, keys: :unique, members: :auto]},
      {Horde.DynamicSupervisor, [name: ObanPoc.HordeSupervisor, strategy: :one_for_one, members: :auto, distribution_strategy: Horde.UniformRandomDistribution]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanPoc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp topologies do
    [
      default: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]
  end
end
