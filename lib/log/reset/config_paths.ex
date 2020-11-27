defmodule Log.Reset.ConfigPaths do
  @moduledoc """
  Creates and clears configured log files.
  """

  alias Log.Reset.Log

  @type levels :: :all | :none | [Logger.level()]
  @type t :: %{Logger.level() => Path.t()}

  @doc """
  Creates and clears the configured log files of given `levels`.
  """
  @spec clear_logs(t, levels) :: [:ok] | :ok
  def clear_logs(config_paths, levels)

  def clear_logs(config_paths, :all) do
    for {_level, path} <- config_paths do
      clear_log(path)
    end
  end

  def clear_logs(_config_paths, :none), do: :ok

  def clear_logs(config_paths, levels) when is_list(levels) do
    for {level, path} <- config_paths, level in levels do
      clear_log(path)
    end
  end

  def clear_logs(_config_paths, _unknown), do: :ok

  @doc """
  Returns a list of configured log paths.
  """
  @spec log_paths(t) :: [Path.t()]
  def log_paths(config_paths) do
    for {_level, path} <- config_paths do
      path
    end
  end

  @doc """
  Returns a map of configured log paths.
  """
  @spec new :: t
  def new do
    for config <- log_configs(), into: %{} do
      {config[:level], config[:path]}
    end
  end

  ## Private functions

  @spec clear_log(Path.t()) :: :ok
  defp clear_log(log_path) do
    log_path = Path.expand(log_path)
    dir_path = Path.dirname(log_path)
    create_dir(dir_path)

    case File.write(log_path, "") do
      :ok -> Log.info(:cleared_log_file, {log_path})
      {:error, reason} -> Log.error(:could_not_clear_log, {log_path, reason})
    end
  end

  @spec log_configs :: [Keyword.t()]
  defp log_configs do
    :logger
    |> :application.get_env(:backends, [])
    |> Enum.map(fn
      {LoggerFileBackend, id} -> :application.get_env(:logger, id, nil)
      _console? -> nil
    end)
    |> Enum.reject(&is_nil/1)
  end

  @spec create_dir(Path.t()) :: :ok
  defp create_dir(dir_path) do
    case File.mkdir_p(dir_path) do
      :ok -> :ok
      {:error, reason} -> Log.error(:could_not_create_dir, {dir_path, reason})
    end
  end
end
