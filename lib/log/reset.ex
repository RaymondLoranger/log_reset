defmodule Log.Reset do
  @moduledoc """
  Resets configured log files.
  """

  alias __MODULE__.LogPaths.Server
  alias __MODULE__.LogPaths

  @typedoc "Log levels"
  @type levels :: [Logger.level()] | :all | :none

  @doc """
  Returns a map assigning configured log paths to their log levels.

  ## Examples

      iex> alias Log.Reset
      iex> Reset.log_paths() |> is_map()
      true
  """
  @spec log_paths :: LogPaths.t()
  def log_paths, do: GenServer.call(Server, :log_paths)

  @doc """
  Refreshes the map assigning configured log paths to their log levels.

  ## Examples

      iex> alias Log.Reset
      iex> Reset.refresh() |> is_map()
      true
  """
  @spec refresh :: LogPaths.t()
  def refresh, do: GenServer.call(Server, :refresh)

  @doc """
  Resets the configured log files of the given `levels`.

  ## Examples

      iex> alias Log.Reset
      iex> # Reset ignored if level not configured...
      iex> Reset.reset_logs([:alert, :critical, :warn])
      :ok
  """
  @spec reset_logs(levels) :: :ok
  def reset_logs(levels) do
    GenServer.call(Server, {:reset_logs, levels})
  end
end
