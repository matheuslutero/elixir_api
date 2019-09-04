defmodule Restfid.Database.Repo.Migrations.ChangeUserPasswordToNonNullable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password_hash, :string, null: false
    end
  end
end
