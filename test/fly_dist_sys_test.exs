defmodule FlyDistSysTest do
  use ExUnit.Case
  doctest FlyDistSys

  test "greets the world" do
    assert FlyDistSys.hello() == :world
  end
end
