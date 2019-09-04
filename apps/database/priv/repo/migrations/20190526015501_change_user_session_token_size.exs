defmodule Restfid.Database.Repo.Migrations.ChangeUserSessionTokenSize do
  use Ecto.Migration

  def change do
    alter table(:user_sessions) do
      modify :token, :string, null: false, size: 500
    end
  end
end
