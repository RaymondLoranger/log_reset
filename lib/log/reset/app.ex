defmodule Log.Reset.App do
  @moduledoc false

  use Application

  use PersistConfig,
    files: ["config/dev.exs", "config/prod.exs", "config/test.exs"]

  alias __MODULE__
  alias Log.Reset

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    if Application.get_env(@app, :reset?),
      do: Reset.log_paths() |> Enum.each(&Reset.clear_log/1)

    Supervisor.start_link([], name: App, strategy: :one_for_one)
  end
end
