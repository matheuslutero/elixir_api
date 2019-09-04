defmodule Restfid.API.AuthErrorHandler do
  use Restfid.API.Controller

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> render(Restfid.API.UserSessionView, "unauthorized.json", error: to_string(type))
  end
end
