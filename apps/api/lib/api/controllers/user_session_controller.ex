defmodule Restfid.API.UserSessionController do
  use Restfid.API.Controller

  alias Restfid.API.SessionHelper

  def create(conn, user_session_params) do
    case SessionHelper.get_new_session(user_session_params) do
      {:ok, user_session} ->
        conn
        |> render("show.json", user_session: user_session)

      {:error, error} ->
        conn
        |> put_status(:unauthorized)
        |> render("unauthorized.json", error: error)
    end
  end
end
