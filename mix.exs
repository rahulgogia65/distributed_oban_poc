defmodule ObanPoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :oban_poc,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx],
      mod: {ObanPoc.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:oban, "~> 2.17"},
      {:postgrex, ">=0.0.0"},
      {:libcluster, "~> 3.3"},
      {:horde, "~> 0.9.0"}
    ]
  end
end
