defmodule Log.Reset.LogPaths do
  @moduledoc """
  A map of configured log paths and functions.
  """

  use PersistConfig

  # Must be in that order given the common 'Log' part...
  alias Log.Reset
  alias Log.Reset.Log

  @typedoc "A map assigning configured log paths to their log levels"
  @type t :: %{Logger.level() => Path.t()}

  @doc """
  Resets the configured log files of the given `levels`.

  ## Examples

      iex> alias Log.Reset.LogPaths
      # The parent app may not configure any file handlers...
      iex> LogPaths.reset_logs([], :all)
      :ok

      iex> alias Log.Reset.LogPaths
      iex> LogPaths.reset_logs([], [:info, :error])
      :ok
  """
  @spec reset_logs(t, Reset.levels()) :: :ok
  def reset_logs(log_paths, :all) when is_map(log_paths) do
    log_paths |> Map.values() |> reset_logs()
  end

  def reset_logs(_log_paths, :none), do: :ok

  def reset_logs(log_paths, levels)
      when is_map(log_paths) and is_list(levels) do
    for {level, log_path} <- log_paths, level in levels do
      log_path
    end
    |> reset_logs()
  end

  def reset_logs(_log_paths, _), do: :ok

  @doc """
  Creates a map assigning each configured log path to its log level.
  """
  @spec new :: t
  def new do
    for {:handler, _handler_id, :logger_std_h,
         %{level: level, config: %{file: path}}} <-
          get_app_env(:file_only_logger, :logger, []),
        into: %{},
        do: {level, path}
  end

  ## Private functions

  @spec reset_logs([Path.t()]) :: :ok
  defp reset_logs(log_paths) do
    log_paths
    # Truncate log files first...
    |> Enum.map(&Task.async(fn -> reset_log(&1) end))
    |> Enum.map(&Task.await/1)
    # Log reset results second...
    |> log_results()
  end

  @spec log_results([tuple]) :: :ok
  defp log_results(results) do
    Enum.reduce(results, :ok, fn
      {:ok, log_path}, _acc ->
        :ok = Log.info(:log_reset, {log_path, __ENV__})

      {:error, reason, log_path}, _acc ->
        :ok = Log.error(:log_not_reset, {log_path, reason, __ENV__})
    end)
  end

  @spec reset_log(Path.t()) :: tuple
  defp reset_log(log_path) do
    log_path = Path.expand(log_path)

    # `File.rm/1` would prevent logging results when file_check > 0.
    case File.open(log_path, [:write]) do
      {:ok, _pid} -> {:ok, log_path}
      {:error, :enoent} -> {:ok, log_path}
      {:error, reason} -> {:error, reason, log_path}
    end
  end
end
