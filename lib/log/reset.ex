defmodule Log.Reset do
  @moduledoc """
  Resets configured log files.
  """

  alias __MODULE__.LogPaths.Server
  alias __MODULE__.LogPaths

  @typedoc "Log levels"
  @type levels :: [Logger.level()] | :all | :none

  @doc """
  Returns a map of configured log paths.

  ## Examples

      iex> alias Log.Reset
      iex> Reset.log_paths()
      %{
        debug: "./log/debug.log",
        error: "./log/error.log",
        info: "./log/info.log",
        warn: "./log/warn.log"
      }
  """
  @spec log_paths :: LogPaths.t()
  def log_paths, do: GenServer.call(Server, :log_paths)

  @doc """
  Refreshes the map of configured log paths from the application environment.

  # ## Examples

  #     iex> alias Log.Reset
  #     iex> old_backends = Application.get_env(:logger, :backends)
  #     iex> new_backends = [:console, {LoggerFileBackend, :warn_log}]
  #     iex> Application.put_env(:logger, :backends, new_backends)
  #     iex> Process.sleep(99)
  #     iex> new_log_paths = Reset.refresh_log_paths()
  #     iex> Application.put_env(:logger, :backends, old_backends)
  #     iex> Process.sleep(99)
  #     iex> new_log_paths
  #     %{warn: "./log/warn.log"}
  """
  @spec refresh_log_paths :: LogPaths.t()
  def refresh_log_paths, do: GenServer.call(Server, :refresh)

  @doc """
  Resets the configured log files of the given `levels`.

  ## Examples

      iex> alias Log.Reset
      iex> # Reset for :alert ignored as not configured...
      iex> Reset.reset_logs([:alert, :warn])
      :ok
  """
  @spec reset_logs(levels) :: :ok
  def reset_logs(levels) do
    GenServer.call(Server, {:reset_logs, levels})
  end
end
