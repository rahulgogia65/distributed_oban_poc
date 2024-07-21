defmodule ObanPoc.File do
  @moduledoc """
  Utility module to fetch files and store them.
  """

  require Logger

  @spec store_file({String.t(), String.t()}, String.t()) :: :ok
  def store_file({source, file}, destination_path) do
    File.cp!(file, destination_path <> "#{source}.json")
    Logger.info("Storing #{source} in #{destination_path}")
  end
end
