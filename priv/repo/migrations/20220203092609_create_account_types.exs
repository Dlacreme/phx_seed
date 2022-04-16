defmodule ToReplace.Repo.Migrations.CreateAccountTypes do
  use Ecto.Migration

  def change do
    create table(:user_types, primary_key: false) do
      add :id, :string, primary_key: true, size: 255
      add :label, :string, size: 255, null: false
    end
  end
end
