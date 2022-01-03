defmodule Log.Reset do
  @moduledoc """
  Resets configured log files.
  """

  alias __MODULE__.ConfigPaths.Server
  alias __MODULE__.ConfigPaths

  @typedoc "Log level"
  @type levels :: [Logger.level()] | :all | :none

  @doc """
  Returns a list of configured log paths.
  """
  @spec log_paths :: [Path.t()]
  def log_paths, do: GenServer.call(Server, :log_paths)

  @doc """
  Returns a map assigning configured log paths to their log levels.
  """
  @spec config_paths :: ConfigPaths.t()
  def config_paths, do: GenServer.call(Server, :config_paths)

  @doc """
  Refreshes the map assigning configured log paths to their log levels.
  """
  @spec refresh :: ConfigPaths.t()
  def refresh, do: GenServer.call(Server, :refresh)

  @doc """
  Resets the configured log files of the given `levels`.
  """
  @spec reset_logs(levels) :: :ok
  def reset_logs(levels) do
    GenServer.call(Server, {:reset_logs, levels})
  end
end
