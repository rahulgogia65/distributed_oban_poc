defmodule ObanPoc.File.Worker do
  use GenServer, restart: :transient

  require Logger
  alias ObanPoc.File

  def child_spec(opts) do
    name = Keyword.get(opts, :name, __MODULE__)

    %{
      id: "#{__MODULE__}_#{name}",
      start: {__MODULE__, :start_link, [name]},
      restart: :transient
    }
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: via_tuple(name))
  end

  @impl true
  def init(_) do
    # Use this to stop the worker after 3 minutes automatically
    # Process.send_after(self(), :stop, :timer.minutes(3))
    {:ok, nil}
  end

  @impl true
  def handle_call({:store_file, {_source, _} = url, destination_path}, _from, state) do
    File.store_file(url, destination_path)

    {:reply, :ok, state}
  end

  @impl true
  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {ObanPoc.HordeRegistry, name}}
end
