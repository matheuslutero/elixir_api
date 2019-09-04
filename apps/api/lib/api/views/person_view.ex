defmodule Restfid.API.PersonView do
  use Restfid.API, :view

  def render("index.json", %{persons: persons}) do
    render_many(persons, __MODULE__, "person.json")
  end

  def render("show.json", %{person: person}) do
    render_one(person, __MODULE__, "person.json")
  end

  def render("person.json", %{person: person}) do
    person
    |> Map.take(Restfid.Database.Person.fields())
  end
end
