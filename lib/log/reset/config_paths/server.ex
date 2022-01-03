defmodule Log.Reset.ConfigPaths.Server do
  @moduledoc """
  A server process that holds, as its state, a map assigning configured log
  paths to their log levels.
  """

  use GenServer

  alias __MODULE__
  alias Log.Reset.ConfigPaths
  alias Log.Reset

  @doc """
  Spawns a "config paths" server process registered under the module name.
  """
  @spec start_link(Reset.levels()) :: GenServer.on_start()
  def start_link(levels) do
    GenServer.start_link(Server, levels, name: Server)
  end

  ## Callbacks

  @spec init(Reset.levels()) :: {:ok, state :: ConfigPaths.t()}
  def init(levels) do
    config_paths = ConfigPaths.new()
    :ok = ConfigPaths.reset_logs(config_paths, levels)
    {:ok, config_paths}
  end

  @spec handle_call(atom | tuple, GenServer.from(), ConfigPaths.t()) ::
          {:reply, reply :: term, state :: ConfigPaths.t()}
  def handle_call(:log_paths, _from, config_paths) do
    {:reply, ConfigPaths.log_paths(config_paths), config_paths}
  end

  def handle_call(:config_paths, _from, config_paths) do
    {:reply, config_paths, config_paths}
  end

  def handle_call(:refresh, _from, _config_paths) do
    config_paths = ConfigPaths.new()
    {:reply, config_paths, config_paths}
  end

  def handle_call({:reset_logs, levels}, _from, config_paths) do
    :ok = ConfigPaths.reset_logs(config_paths, levels)
    {:reply, :ok, config_paths}
  end
end
