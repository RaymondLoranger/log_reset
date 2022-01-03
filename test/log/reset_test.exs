defmodule Log.ResetTest do
  use ExUnit.Case, async: true

  alias Log.Reset

  doctest Reset

  describe "log_paths/0" do
    test "returns a map" do
      assert Reset.log_paths() ==
               %{
                 debug: "./log/debug.log",
                 error: "./log/error.log",
                 info: "./log/info.log",
                 warn: "./log/warn.log"
               }
    end
  end
end
