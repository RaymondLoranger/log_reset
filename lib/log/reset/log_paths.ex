defmodule Log.Reset.LogPaths do
  @moduledoc """
  A map of configured log paths and functions.
  """

  use PersistConfig

  # Must be in that order given the common 'Log' part...
  alias Log.Reset
  alias Log.Reset.Log

  @typedoc "A map assigning configured log paths to their log levels"
  @type t :: %{:logger.level() => Path.t()}

  @doc """
  Creates a map assigning each configured log path to its log level.
  """
  @spec new :: t
  def new do
    import :logger, only: [get_handler_ids: 0, get_handler_config: 1]

    for id <- get_handler_ids(),
        id not in [:default, :ssl_handler],
        into: %{} do
      {:ok, %{config: %{file: path}, level: level}} = get_handler_config(id)
      {level, path}
    end
  end

  @doc """
  Resets the configured log files of the given `levels`.

  ## Examples

      iex> alias Log.Reset.LogPaths
      iex> LogPaths.reset_logs(%{}, :all) # No handlers configured?
      :ok

      iex> alias Log.Reset.LogPaths
      iex> LogPaths.reset_logs(%{}, [:info, :error]) # No handlers either?
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

  def reset_logs(_log_paths, _levels), do: :ok

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
    for result <- results, reduce: :ok do
      :ok ->
        case result do
          {:ok, log_path} ->
            :ok = Log.debug(:log_reset, {log_path, __ENV__})

          {:error, reason, log_path} ->
            :ok = Log.error(:log_not_reset, {log_path, reason, __ENV__})
        end
    end
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
