defmodule Cvme.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  @disable_migration_lock true
  @disable_ddl_transaction true

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
