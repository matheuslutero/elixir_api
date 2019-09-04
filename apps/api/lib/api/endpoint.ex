defmodule Restfid.API.Endpoint do
  use Phoenix.Endpoint, otp_app: :api

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head

  plug Restfid.API.Router
end
