defmodule Log.Reset do
  @moduledoc """
  Resets configured log files.
  """

  alias __MODULE__.LogPaths.Server
  alias __MODULE__.LogPaths

  @typedoc "Log levels"
  @type levels :: :all | :none | [:logger.level()]

  @doc """
  Returns a map of configured log paths.

  ## Examples

      iex> alias Log.Reset
      iex> Reset.log_paths()
      # Alphabetical list of absolute paths...
      %{
        debug: ~c"#{File.cwd!()}/log/debug.log",
        error: ~c"#{File.cwd!()}/log/error.log",
        info: ~c"#{File.cwd!()}/log/info.log",
        warning: ~c"#{File.cwd!()}/log/warning.log"
      }
  """
  @spec log_paths :: LogPaths.t()
  def log_paths, do: GenServer.call(Server, :log_paths)

  @doc """
  Refreshes the map of configured log paths.
  """
  @spec refresh_log_paths :: LogPaths.t()
  def refresh_log_paths, do: GenServer.call(Server, :refresh)

  @doc """
  Resets the configured log files of the given `levels`.

  ## Examples

      iex> alias Log.Reset
      iex> # No logs reset as log paths not configured...
      iex> Reset.reset_logs([:alert, :notice])
      :ok
  """
  @spec reset_logs(levels) :: :ok
  def reset_logs(levels \\ :all) do
    GenServer.call(Server, {:reset_logs, levels})
  end
end
