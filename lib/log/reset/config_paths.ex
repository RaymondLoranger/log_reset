defmodule Log.Reset.ConfigPaths do
  @moduledoc """
  Creates and clears configured log files.
  """

  # Must be in that order given the common 'Log' part...
  alias Log.Reset
  alias Log.Reset.Log

  @type t :: %{Logger.level() => Path.t()}

  @doc """
  Creates and clears the configured log files of given `levels`.
  """
  @spec clear_logs(t, Reset.levels()) :: :ok
  def clear_logs(config_paths, levels)

  def clear_logs(config_paths, :all) do
    Enum.reduce(config_paths, :ok, fn {_level, path}, _acc ->
      clear_log(path)
    end)
  end

  def clear_logs(_config_paths, :none), do: :ok

  def clear_logs(config_paths, levels) when is_list(levels) do
    Enum.reduce(config_paths, :ok, fn {level, path}, acc ->
      if level in levels, do: clear_log(path), else: acc
    end)
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
      :ok -> Log.info(:cleared, {log_path, __ENV__})
      {:error, reason} -> Log.error(:not_cleared, {log_path, reason, __ENV__})
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
      {:error, reason} -> Log.error(:not_created, {dir_path, reason, __ENV__})
    end
  end
end
