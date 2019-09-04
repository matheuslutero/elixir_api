defmodule MasterProxy.Plug do
  def init(opts) do
    Enum.into(opts, %{})
  end

  def call(conn, opts) do
    cond do
      conn.host =~ ~r{^api.} ->
        opts.api_endpoint.call(conn, [])

      true ->
        opts.browser_endpoint.call(conn, [])
    end
  end
end
