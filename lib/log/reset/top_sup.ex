defmodule Log.Reset.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset.ConfigPathsServer, as: Server

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on `use GenServer`...
      {Server, get_env(:levels, :all)}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
