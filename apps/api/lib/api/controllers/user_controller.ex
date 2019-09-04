defmodule Restfid.API.UserController do
  use Restfid.API.Controller

  alias Restfid.Database.{UserReader, UserWriter}

  def index(conn, _params) do
    users = UserReader.all()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    case UserWriter.insert(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end

  def show(conn, %{"id" => id}) do
    user = UserReader.get!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id} = user_params) do
    user = UserReader.get!(id)

    case UserWriter.update(user, user_params) do
      {:ok, user} ->
        render(conn, "show.json", user: user)

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    case UserWriter.delete(UserReader.get!(id)) do
      {:ok, _user} ->
        send_resp(conn, :no_content, "")

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end
end
