defmodule Restfid.API.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :api,
    module: Restfid.API.Guardian,
    error_handler: Restfid.API.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
