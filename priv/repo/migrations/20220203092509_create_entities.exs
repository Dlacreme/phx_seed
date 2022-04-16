defmodule ToReplace.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :label, :string, size: 512, null: false
      add :description, :string, size: 1024, null: true
      add :picture_url, :string, size: 2042, null: true
      add :disabled_at, :utc_datetime, null: true

      timestamps(updated_at: false)
    end
  end
end
