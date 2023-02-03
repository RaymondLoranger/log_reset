defmodule Log.Reset.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset.LogPaths.Server
  alias Log.Reset

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_start_type, :ok = _start_args) do
    [
      # Child spec relying on `use GenServer`...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
    |> tap(&startup_reset/1)
  end

  ## Private functions

  @spec startup_reset(tuple) :: :ok
  defp startup_reset({:ok, _pid}) do
    get_env(:levels, :all) |> Reset.reset_logs()
  end
end
