defmodule Log.Reset.App do
  @moduledoc false

  use Application

  alias __MODULE__
  alias Log.Reset

  @error_path Application.get_env(:logger, :error_log)[:path]
  @info_path Application.get_env(:logger, :info_log)[:path]
  @warn_path Application.get_env(:logger, :warn_log)[:path]

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    unless Mix.env() == :test do
      [@error_path, @info_path, @warn_path] |> Enum.each(&Reset.clear_log/1)
    end

    [] |> Supervisor.start_link(name: App, strategy: :one_for_one)
  end
end
