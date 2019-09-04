defmodule Restfid.Database.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :phone, :string, size: 25, null: false
      add :role, :string, size: 25, null: false
      add :state, :string, size: 25, null: false
      add :settings, :map, default: "{}", null: false
      add(:person_id, references(:persons, on_delete: :nothing))

      timestamps()
    end

    create(index(:users, [:person_id]))
    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:phone]))
  end
end
