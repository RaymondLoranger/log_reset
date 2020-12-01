defmodule Log.Reset.Log do
  use File.Only.Logger

  info :log_reset, {log_path} do
    """
    \nLog file successfully reset...
    • Path:
      #{inspect(log_path)}
    #{from()}
    """
  end

  error :log_not_reset, {log_path, reason} do
    """
    \nCould not reset log file...
    • Path:
      #{inspect(log_path)}
    • Reason:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end
end
