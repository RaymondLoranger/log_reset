defmodule Log.Reset do
  @moduledoc """
  Creates and clears configured log files.
  """

  alias __MODULE__.ConfigPaths
  alias __MODULE__.ConfigPathsServer, as: Server

  @doc """
  Returns a list of configured log paths.
  """
  @spec log_paths :: [Path.t()]
  def log_paths, do: GenServer.call(Server, :log_paths)

  @doc """
  Returns a map of configured log paths.
  """
  @spec config_paths :: ConfigPaths.t()
  def config_paths, do: GenServer.call(Server, :config_paths)

  @doc """
  Refreshes the map of configured log paths.
  """
  @spec refresh :: :ok
  def refresh, do: GenServer.cast(Server, :refresh)

  @doc """
  Clears the configured log files of given `levels`.
  """
  @spec clear_logs(ConfigPaths.levels()) :: :ok
  def clear_logs(levels) do
    GenServer.cast(Server, {:clear_logs, levels})
  end
end
