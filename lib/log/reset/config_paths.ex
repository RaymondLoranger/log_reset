defmodule Log.Reset.ConfigPaths do
  @moduledoc """
  A map assigning configured log paths to their log levels, and functions.
  A map assigning backend log paths to their log levels, and functions.
  """

  # Must be in that order given the common 'Log' part...
  alias Log.Reset
  alias Log.Reset.Log

  @typedoc "A map assigning configured log paths to their log levels"
  @type t :: %{Logger.level() => Path.t()}

  @doc """
  Resets the configured log files of the given `levels`.
  """
  @spec reset_logs(t, Reset.levels()) :: :ok
  def reset_logs(config_paths, :all) do
    log_paths(config_paths) |> reset_logs()
  end

  def reset_logs(_config_paths, :none), do: :ok

  def reset_logs(config_paths, levels) when is_list(levels) do
    for {level, log_path} <- config_paths, level in levels do
      log_path
    end
    |> reset_logs()
  end

  def reset_logs(_config_paths, _), do: :ok

  @doc """
  Returns a list of configured log paths.
  """
  @spec log_paths(t) :: [Path.t()]
  def log_paths(config_paths), do: Map.values(config_paths)

  @doc """
  Returns a map assigning each configured log path to its log level.
  """
  @spec new :: t
  def new do
    for config <- log_configs(), into: %{} do
      {config[:level], config[:path]}
    end
  end

  ## Private functions

  @spec reset_logs([Path.t()]) :: :ok
  defp reset_logs(log_paths) do
    log_paths
    # Delete log files first...
    |> Enum.map(&Task.async(fn -> reset_log(&1) end))
    |> Enum.map(&Task.await/1)
    # Process results second...
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

    case File.rm(log_path) do
      :ok -> {:ok, log_path}
      {:error, :enoent} -> {:ok, log_path}
      {:error, reason} -> {:error, reason, log_path}
    end
  end

  @spec log_configs :: [Keyword.t()]
  defp log_configs do
    :application.get_env(:logger, :backends, [])
    |> Enum.map(fn
      {LoggerFileBackend, id} -> :application.get_env(:logger, id, nil)
      _console -> nil
    end)
    |> Enum.reject(&is_nil/1)
  end
end
