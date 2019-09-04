defmodule Restfid.API.UserSessionView do
  use Restfid.API, :view

  def render("unauthorized.json", %{error: error}) do
    %{error: error}
  end

  def render("show.json", %{user_session: user_session}) do
    render_one(user_session, __MODULE__, "user_session.json")
  end

  def render("user_session.json", %{user_session: user_session}) do
    user_session
    |> Map.take(Restfid.Database.UserSession.fields())
  end
end
