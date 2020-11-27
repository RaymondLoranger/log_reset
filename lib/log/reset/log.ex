defmodule Log.Reset.Log do
  use File.Only.Logger

  error :could_not_clear_log, {log_path, reason} do
    """
    \nCould not clear log file...
    • Path:
      #{inspect(log_path)}
    • Reason:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end

  error :could_not_create_dir, {dir_path, reason} do
    """
    \nCould not create directory...
    • Path:
      #{inspect(dir_path)}
    • Reason:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end

  info :cleared_log_file, {log_path} do
    """
    \nCleared log file...
    • Path:
      #{inspect(log_path)}
    #{from()}
    """
  end
end
