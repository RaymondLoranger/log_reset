defmodule Log.ResetTest do
  use ExUnit.Case, async: true

  alias Log.Reset

  doctest Reset

  describe "log_paths/0" do
    test "returns a map" do
      # May be empty map...
      assert Reset.log_paths() |> is_map()
    end
  end
end
