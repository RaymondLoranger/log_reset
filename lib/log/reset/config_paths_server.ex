defmodule Log.Reset.ConfigPathsServer do
  @moduledoc """
  A server process that holds a map of configured log paths as its state.
  """

  use GenServer

  alias __MODULE__, as: Server
  alias Log.Reset.ConfigPaths

  @type from :: GenServer.from()
  @type handle_call :: {:reply, reply :: term, state :: ConfigPaths.t()}
  @type handle_info :: {:noreply, state :: ConfigPaths.t()}
  @type init :: {:ok, state :: ConfigPaths.t()}
  @type message :: tuple
  @type on_start :: GenServer.on_start()
  @type request :: atom | tuple

  @doc """
  Spawns a config paths server process registered under the module name.
  """
  @spec start_link(ConfigPaths.levels()) :: on_start
  def start_link(levels), do: GenServer.start_link(Server, levels, name: Server)

  ## Callbacks

  @spec init(ConfigPaths.levels()) :: init
  def init(levels) do
    self() |> send({:clear_logs, levels})
    {:ok, ConfigPaths.new()}
  end

  @spec handle_call(request, from, ConfigPaths.t()) :: handle_call
  def handle_call(:log_paths, _from, config_paths) do
    {:reply, ConfigPaths.log_paths(config_paths), config_paths}
  end

  def handle_call(:config_paths, _from, config_paths) do
    {:reply, config_paths, config_paths}
  end

  def handle_call(:refresh, _config_paths) do
    {:noreply, ConfigPaths.new(), ConfigPaths.new()}
  end

  def handle_call({:clear_logs, levels}, config_paths) do
    {:noreply, ConfigPaths.clear_logs(config_paths, levels), config_paths}
  end

  @spec handle_info(message, ConfigPaths.t()) :: handle_info
  def handle_info({:clear_logs, levels}, config_paths) do
    ConfigPaths.clear_logs(config_paths, levels)
    {:noreply, config_paths}
  end
end
