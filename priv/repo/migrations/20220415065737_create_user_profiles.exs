defmodule ToReplace.Repo.Migrations.CreateUserProfiles do
  use Ecto.Migration

  def change do
    create table(:user_profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, size: 500, null: true
      add :picture_url, :string, size: 2048, null: true
      add :phone_number, :string, size: 24, null: true

      timestamps()
    end
  end
end
