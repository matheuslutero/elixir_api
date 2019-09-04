defmodule Restfid.Database.Person do
  use Restfid.Database.Model

  @fields ~w(id
            name
            lastname
            nickname
            birth_date
            address_street
            address_street_number
            address_sublocality
            address_locality
            address_state
            address_country
            address_postal_code
            is_active)a

  schema "persons" do
    field(:name, :string)
    field(:lastname, :string)
    field(:nickname, :string)
    field(:birth_date, :date)
    field(:address_street, :string)
    field(:address_street_number, :string)
    field(:address_sublocality, :string)
    field(:address_locality, :string)
    field(:address_state, :string)
    field(:address_country, :string)
    field(:address_postal_code, :string)
    field(:is_active, :boolean, default: true)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required([:name, :lastname, :is_active])
    |> validate_length(
      [
        :name,
        :lastname,
        :nickname,
        :address_street,
        :address_street_number,
        :address_sublocality,
        :address_locality,
        :address_state,
        :address_country,
        :address_postal_code
      ],
      max: 255
    )
  end

  def fields, do: @fields
end
