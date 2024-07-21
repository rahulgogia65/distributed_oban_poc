# ObanPoc

This is a PoC which creates a distributed oban job using horde

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `oban_poc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:oban_poc, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/oban_poc>.


iex --sname oban1 -S mix
iex --sname oban2 -S mix
iex --sname oban3 -S mix


ObanPoc.Periodic.FileFetcher.new(%{}) |> Oban.insert
