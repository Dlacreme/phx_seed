defmodule ToReplace.Repo.Migrations.AddEntityCreatedBy do
  use Ecto.Migration

  def change do
    alter table(:entities) do
      add :created_by_id, references(:users, type: :binary_id), null: false
    end
  end
end
