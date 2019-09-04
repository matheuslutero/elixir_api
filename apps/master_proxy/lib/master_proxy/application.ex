defmodule MasterProxy.Application do
  @moduledoc false

  use Application

  require Logger

  alias Plug.Adapters.Cowboy

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = children(Application.get_env(:master_proxy, :serve_endpoints))
    opts = [strategy: :one_for_one, name: MasterProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def children(true) do
    port = String.to_integer(System.get_env("PORT") || "3333")

    plug_opts = [
      api_endpoint: Restfid.API.Endpoint
    ]

    Logger.info("""
    Running the following endpoints under http://localhost:#{port}

      #{inspect(plug_opts)}
    """)

    [Cowboy.child_spec(:http, MasterProxy.Plug, plug_opts, port: port)]
  end

  def children(_), do: []
end
