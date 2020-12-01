defmodule Log.Reset.ConfigPaths.Server do
  @moduledoc """
  A server process that holds a map of configured log paths as its state.
  """

  use GenServer

  alias __MODULE__
  alias Log.Reset.ConfigPaths
  alias Log.Reset

  @type from :: GenServer.from()
  @type handle_call :: {:reply, reply :: term, state :: ConfigPaths.t()}
  @type init :: {:ok, state :: ConfigPaths.t()}
  @type on_start :: GenServer.on_start()
  @type request :: atom | tuple

  @doc """
  Spawns a config paths server process registered under the module name.
  """
  @spec start_link(Reset.levels()) :: on_start
  def start_link(levels) do
    GenServer.start_link(Server, levels, name: Server)
  end

  ## Callbacks

  @spec init(Reset.levels()) :: init
  def init(levels) do
    config_paths = ConfigPaths.new()
    :ok = ConfigPaths.reset_logs(config_paths, levels)
    {:ok, config_paths}
  end

  @spec handle_call(request, from, ConfigPaths.t()) :: handle_call
  def handle_call(:log_paths, _from, config_paths) do
    {:reply, ConfigPaths.log_paths(config_paths), config_paths}
  end

  def handle_call(:config_paths, _from, config_paths) do
    {:reply, config_paths, config_paths}
  end

  def handle_call(:refresh, _config_paths) do
    config_paths = ConfigPaths.new()
    {:reply, config_paths, config_paths}
  end

  def handle_call({:reset_logs, levels}, config_paths) do
    :ok = ConfigPaths.reset_logs(config_paths, levels)
    {:reply, :ok, config_paths}
  end
end
