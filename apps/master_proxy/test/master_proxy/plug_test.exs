defmodule MasterProxy.PlugTest do
  use ExUnit.Case

  import MasterProxy.Plug

  defmodule API do
    def call(_, _), do: "API"
  end

  defmodule Browser do
    def call(_, _), do: "Browser"
  end

  @opts %{api_endpoint: API, browser_endpoint: Browser}

  test "call/2 must redirect to the api or browser depending on subdomain" do
    assert call(%Plug.Conn{host: "api.appfid.com"}, @opts) == "API"
    assert call(%Plug.Conn{host: "www.appfid.com"}, @opts) == "Browser"
  end
end
