defmodule ToReplace.Repo.Migrations.CreateTokenTypes do
  use Ecto.Migration

  def change do
    create table(:token_types, primary_key: false) do
      add :id, :string, primary_key: true, size: 125
      add :label, :string, size: 255
    end
  end
end
