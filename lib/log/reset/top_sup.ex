defmodule Log.Reset.TopSup do
  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    if reset?(), do: Reset.clear_logs()
    Supervisor.start_link([], name: TopSup, strategy: :one_for_one)
  end

  ## Private functions

  @spec reset? :: boolean
  defp reset?, do: get_env(:reset?, false)
end
