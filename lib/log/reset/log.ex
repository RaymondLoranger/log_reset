defmodule Log.Reset.Log do
  use File.Only.Logger

  info :log_reset, {log_path, env} do
    """
    \nLog file reset successfully...
    • Path:
      #{inspect(log_path)}
    #{from(env)}
    """
  end

  error :log_not_reset, {log_path, reason, env} do
    """
    \nCould not reset log file...
    • Path:
      #{inspect(log_path)}
    • Reason:
      #{:file.format_error(reason) |> inspect()}
    #{from(env)}
    """
  end
end
