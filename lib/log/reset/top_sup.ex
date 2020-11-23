defmodule Log.Reset.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset.ConfigPaths
  alias Log.Reset.ConfigPathsServer, as: Server

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on `use GenServer`...
      {Server, levels()}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end

  ## Private functions

  @spec levels :: ConfigPaths.levels()
  defp levels, do: get_env(:levels, :all)
end
