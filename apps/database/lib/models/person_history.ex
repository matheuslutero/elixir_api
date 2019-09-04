defmodule Restfid.Database.PersonHistory do
  use Restfid.Database.Model

  @fields ~w(id
            person_id,
            change_user_id,
            changes)a

  schema "person_history" do
    field :changes, :map

    belongs_to :person, Restfid.Database.Person
    belongs_to :change_user, Restfid.Database.User

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required([
      :person_id,
      :change_user_id,
      :changes
    ])
  end

  def fields, do: @fields
end
