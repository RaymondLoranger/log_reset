defmodule Log.Reset do
  @moduledoc """
  Creates and clears configured log files.
  """

  require Logger

  @doc """
  Creates and clears all log files.
  """
  @spec clear_logs :: :ok
  def clear_logs, do: log_paths() |> Enum.each(&clear_log/1)

  @doc """
  Creates and clears a log file.
  """
  @spec clear_log(Path.t()) :: :ok
  def clear_log(log_path) do
    log_path = Path.expand(log_path)
    dir_path = Path.dirname(log_path)
    create_dir(dir_path)

    case File.write(log_path, "") do
      :ok -> info("Cleared log file", log_path)
      {:error, reason} -> error(reason, "Couldn't clear log file", log_path)
    end
  end

  @doc """
  Lists all configured log paths.
  """
  @spec log_paths :: [Path.t()]
  def log_paths do
    :logger
    |> :application.get_env(:backends, [])
    |> Enum.map(fn
      {LoggerFileBackend, id} -> :application.get_env(:logger, id, nil)[:path]
      _console? -> nil
    end)
    |> Enum.reject(&is_nil/1)
  end

  ## Private functions

  @spec create_dir(Path.t()) :: :ok
  defp create_dir(dir_path) do
    case File.mkdir_p(dir_path) do
      :ok -> :ok
      {:error, reason} -> error(reason, "Couldn't create directory", dir_path)
    end
  end

  @spec info(String.t(), Path.t()) :: :ok
  defp info(msg, path) do
    Logger.info("""
    \n#{msg}:
    #{inspect(path)}
    """)
  end

  @spec error(File.posix(), String.t(), Path.t()) :: :ok
  defp error(reason, msg, path) do
    Logger.error("""
    \n#{msg}:
    #{inspect(path)}
    #{:file.format_error(reason)}
    """)
  end
end
