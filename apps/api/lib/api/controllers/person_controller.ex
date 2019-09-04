defmodule Restfid.API.PersonController do
  use Restfid.API.Controller

  alias Restfid.Database.{PersonReader, PersonWriter}

  def index(conn, _params) do
    persons = PersonReader.all()
    render(conn, "index.json", persons: persons)
  end

  def create(conn, person_params) do
    case PersonWriter.insert(person_params) do
      {:ok, person} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", person_path(conn, :show, person))
        |> render("show.json", person: person)

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end

  def show(conn, %{"id" => id}) do
    person = PersonReader.get!(id)
    render(conn, "show.json", person: person)
  end

  def update(conn, %{"id" => id} = person_params) do
    person = PersonReader.get!(id)

    case PersonWriter.update(person, person_params) do
      {:ok, person} ->
        render(conn, "show.json", person: person)

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    case PersonWriter.delete(PersonReader.get!(id)) do
      {:ok, _person} ->
        send_resp(conn, :no_content, "")

      {:error, form_data} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Restfid.API.ChangesetView, "error.json", changeset: form_data)
    end
  end
end
