defmodule Restfid.Database.Repo.Migrations.CreateUserHistory do
  use Ecto.Migration

  def change do
    create table(:user_history) do
      add :changes, :map, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :change_user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create(index(:user_history, [:user_id]))
    create(index(:user_history, [:change_user_id]))
  end
end
