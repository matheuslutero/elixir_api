defmodule Restfid.Database.Repo.Migrations.CreatePersonHistory do
  use Ecto.Migration

  def change do
    create table(:person_history) do
      add :changes, :map, null: false
      add :person_id, references(:persons, on_delete: :nothing), null: false
      add :change_user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create(index(:person_history, [:person_id]))
    create(index(:person_history, [:change_user_id]))
  end
end
