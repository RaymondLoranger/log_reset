defmodule Log.Reset.LogPaths.Server do
  @moduledoc """
  A server process that holds, as its state, a map assigning configured log
  paths to their log levels.
  """

  use GenServer

  alias __MODULE__
  alias Log.Reset.LogPaths

  @doc """
  Spawns a "log paths" server process registered under the module name.
  """
  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok = _init_arg) do
    GenServer.start_link(Server, :ok, name: Server)
  end

  ## Callbacks

  @spec init(term) :: {:ok, state :: LogPaths.t()}
  def init(:ok = _init_arg) do
    {:ok, LogPaths.new()}
  end

  @spec handle_call(atom | tuple, GenServer.from(), LogPaths.t()) ::
          {:reply, reply :: term, state :: LogPaths.t()}
  def handle_call(:log_paths, _from, log_paths) do
    {:reply, log_paths, log_paths}
  end

  def handle_call(:refresh, _from, _log_paths) do
    log_paths = LogPaths.new()
    {:reply, log_paths, log_paths}
  end

  def handle_call({:reset_logs, levels}, _from, log_paths) do
    :ok = LogPaths.reset_logs(log_paths, levels)
    {:reply, :ok, log_paths}
  end
end
