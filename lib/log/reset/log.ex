defmodule Log.Reset.Log do
  use File.Only.Logger

  info :log_reset, {log_path, env} do
    """
    \nLog file reset successfully...
    • Path: #{inspect(log_path) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end

  error :log_not_reset, {log_path, reason, env} do
    """
    \nCould not reset log file...
    • Path: #{inspect(log_path) |> maybe_break(8)}
    • Reason: #{"'#{:file.format_error(reason)}'" |> maybe_break(10)}
    #{from(env, __MODULE__)}\
    """
  end
end
