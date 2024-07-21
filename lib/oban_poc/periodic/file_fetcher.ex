defmodule ObanPoc.Periodic.FileFetcher do
  use Oban.Worker, queue: :default

  require Logger

  alias ObanPoc.File

  @urls for i <- 1..10,
            do:
              {"file#{i}",
               "/home/rahulgogia/projects/elixir_learning/oban_poc/files_source/file#{i}.json"}

  @destination_path "/home/rahulgogia/projects/elixir_learning/oban_poc/files_storage/"

  @impl Oban.Worker
  def perform(%Oban.Job{args: _args}) do
    result = @urls
    |> Enum.map(&Task.async(fn -> distribute_store_file(&1) end))
    |> Task.await_many(:infinity)

    if Enum.all?(result, &(&1 == :ok)) do
      :ok
    else
      Logger.error("Failed to store files")
      # This is not ideal as it will bump the max attempts on the job.
      {:snooze, :timer.seconds(2)}
    end
  end

  defp distribute_store_file({source, url}) do
    case Horde.DynamicSupervisor.start_child(ObanPoc.HordeSupervisor, {File.Worker, name: source}) do
      {:ok, pid} ->
        dbg({pid, source})
        Process.sleep(500)
        :ok = GenServer.call(via_tuple(source), {:store_file, {source, url}, @destination_path})
        # Manually stopping the child. This is just for demo purposes. See `init/1` of `File.Worker` for more info.
        GenServer.cast(via_tuple(source), :stop)

      {:error, reason} ->
        Logger.error("Failed to start child #{source}: #{inspect(reason)}")
        {:error, reason}
    end
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {ObanPoc.HordeRegistry, name}}
end
