defmodule Log.Reset.App do
  @moduledoc false

  use Application
  use PersistConfig

  alias __MODULE__
  alias Log.Reset

  @env Application.get_env(@app, :env)

  @dialyzer {:nowarn_function, start: 2}
  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    unless @env == :test do
      Reset.log_paths() |> Enum.each(&Reset.clear_log/1)
    end

    [] |> Supervisor.start_link(name: App, strategy: :one_for_one)
  end
end
