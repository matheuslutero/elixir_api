defmodule Restfid.Database.Repo.Migrations.CreateUserSessions do
  use Ecto.Migration

  def change do
    create table(:user_sessions) do
      add :token, :string, null: false
      add :device_model, :string
      add :device_platform, :string, size: 25
      add :notification_player_id, :string
      add :app_version, :string, null: false
      add :expiration_date, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create(index(:user_sessions, [:user_id]))
  end
end
