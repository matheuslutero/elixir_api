defmodule Restfid.Database.UserHistory do
  use Restfid.Database.Model

  @fields ~w(id
            user_id
            change_user_id
            changes)a

  schema "user_history" do
    field :changes, :map

    belongs_to :user, Restfid.Database.User
    belongs_to :change_user, Restfid.Database.User

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required([
      :user_id,
      :change_user_id,
      :changes
    ])
  end

  def fields, do: @fields
end
