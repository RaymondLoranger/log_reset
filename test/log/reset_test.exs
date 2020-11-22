defmodule Log.ResetTest do
  use ExUnit.Case, async: true

  alias Log.Reset

  doctest Reset

  describe "log_paths/0" do
    test "returns a list of configured log paths" do
      assert Reset.log_paths() |> is_list()
    end
  end

  describe "config_paths/0" do
    test "returns a map of configured log paths" do
      assert Reset.config_paths() == %{
               debug: "./log/debug.log",
               info: "./log/info.log",
               warn: "./log/warn.log",
               error: "./log/error.log"
             }
    end
  end
end
