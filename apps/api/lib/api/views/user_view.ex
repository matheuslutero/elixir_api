defmodule Restfid.API.UserView do
  use Restfid.API, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    user
    |> Map.take(Restfid.Database.User.fields())
  end
end
