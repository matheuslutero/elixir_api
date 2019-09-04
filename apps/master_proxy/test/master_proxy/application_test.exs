defmodule MasterProxy.ApplicationTest do
  use ExUnit.Case

  import MasterProxy.Application

  test "children/1 returns a cowboy child_spec" do
    assert children(false) == []
    assert [{{:ranch_listener_sup, MasterProxy.Plug.HTTP}, _, _, _, _, _}] = children(true)
  end
end
