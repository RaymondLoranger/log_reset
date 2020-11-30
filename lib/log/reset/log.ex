defmodule Log.Reset.Log do
  use File.Only.Logger

  info :cleared, {log_path, env} do
    """
    \nCleared log file...
    • Inside function:
      #{fun(env)}
    • Path:
      #{inspect(log_path)}
    #{from()}
    """
  end

  error :not_cleared, {log_path, reason, env} do
    """
    \nCould not clear log file...
    • Inside function:
      #{fun(env)}
    • Path:
      #{inspect(log_path)}
    • Reason:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end

  error :not_created, {dir_path, reason, env} do
    """
    \nCould not create directory...
    • Inside function:
      #{fun(env)}
    • Path:
      #{inspect(dir_path)}
    • Reason:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end
end
