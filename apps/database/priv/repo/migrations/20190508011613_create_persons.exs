defmodule Restfid.Database.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :name, :string, null: false
      add :lastname, :string, null: false
      add :nickname, :string
      add :birth_date, :date
      add :address_street, :string
      add :address_street_number, :string
      add :address_sublocality, :string
      add :address_locality, :string
      add :address_state, :string
      add :address_country, :string
      add :address_postal_code, :string
      add :is_active, :boolean, default: true, null: false

      timestamps()
    end

  end
end
