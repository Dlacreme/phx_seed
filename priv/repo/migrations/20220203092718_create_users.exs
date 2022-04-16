defmodule ToReplace.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  alias ToReplace.Repo
  alias ToReplace.Account.UserType

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    Repo.insert!(%UserType{
      id: "admin",
      label: "Admin"
    })

    Repo.insert!(%UserType{
      id: "user",
      label: "User"
    })

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: true
      add :password, :string, size: 1024, null: true
      add :type_id, references(:user_types, type: :string), size: 255, default: "user"

      timestamps(updated_at: false)
    end

    create index(:users, [:id])
    create unique_index(:users, :email, name: :unique_index_user_email)
  end
end
