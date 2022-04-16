defmodule ToReplace.Repo.Migrations.AddProfileToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profile_id, references(:user_profiles, type: :binary_id), null: false
    end
  end
end
