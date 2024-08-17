defmodule Cvme.Repo.Migrations.AddExperiencesTable do
  use Ecto.Migration

  @disable_migration_lock true
  @disable_ddl_transaction true

  def change do
    create table(:experiences) do
      add :company, :string, null: false
      add :description, :string
      add :start_date, :date, null: false
      add :end_date, :date
      add :user_id, references(:users)

      timestamps()
    end
  end
end
