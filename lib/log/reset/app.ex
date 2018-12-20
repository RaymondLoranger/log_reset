defmodule Log.Reset.App do
  @moduledoc false

  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset

  @dialyzer {:nowarn_function, start: 2}
  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    if Application.get_env(@app, :reset?),
      do: Reset.log_paths() |> Enum.each(&Reset.clear_log/1)

    Supervisor.start_link([], name: App, strategy: :one_for_one)
  end
end
