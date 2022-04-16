defmodule ToReplace.Repo.Migrations.CreateTokens do
  use Ecto.Migration
  alias ToReplace.Repo
  alias ToReplace.Account.TokenType

  def change do
    Repo.insert(%TokenType{
      id: "account_validation",
      label: "Account Validation"
    })

    Repo.insert(%TokenType{
      id: "password_recovery",
      label: "Password Recovery"
    })

    Repo.insert(%TokenType{
      id: "authentication",
      label: "Authentication Code"
    })

    Repo.insert(%TokenType{
      id: "authorization",
      label: "Authorization"
    })

    create table(:tokens, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :string, null: false, size: 512
      add :deprecated_at, :utc_datetime, null: false
      add :type_id, references(:token_types, type: :string), size: 125, null: false
      add :user_id, references(:users, type: :binary_id), null: false

      timestamps(updated_at: false)
    end
  end
end
