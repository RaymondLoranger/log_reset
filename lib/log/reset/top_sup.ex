defmodule Log.Reset.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset.LogPaths.Server
  alias Log.Reset

  # @impl Application
  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_start_type, :ok = _start_args) do
    [
      # Child spec relying on `use GenServer`...
      {Server, levels()}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end

  ## Private functions

  @spec levels :: Reset.levels()
  defp levels, do: get_env(:levels, :all)
end
