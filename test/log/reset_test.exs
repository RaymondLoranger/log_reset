defmodule Log.ResetTest do
  use ExUnit.Case, async: true
  use PersistConfig

  require Logger

  alias Log.Reset

  @env get_env(:env)

  doctest Reset

  describe "Reset.log_paths/0" do
    test "returns a map" do
      root_dir = File.cwd!()
      # Listed alphabetically...
      assert Reset.log_paths() ==
               %{
                 debug: ~c"#{root_dir}/log/debug.log",
                 error: ~c"#{root_dir}/log/error.log",
                 info: ~c"#{root_dir}/log/info.log",
                 warning: ~c"#{root_dir}/log/warning.log"
               }
    end
  end

  describe "config/runtime.exs overrides config/config.exs" do
    test "runtime.exs if present overrides config.exs" do
      if File.exists?("config/runtime.exs") do
        Logger.notice("'config/runtime.exs' exists...")
        Logger.notice("env is #{@env}")
        assert @env == "test ➔ from config/runtime.exs"
      else
        Logger.notice("'config/runtime.exs' does not exist...")
        Logger.notice("env is #{@env}")
        assert @env == "test ➔ from config/config.exs"
      end
    end
  end
end
