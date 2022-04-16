defmodule ToReplace.Account.TokenType do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "token_types" do
    field :label, :string
  end

  def authorization, do: "authorization"
  def password_recovery, do: "password_recovery"
  def account_validation, do: "account_validation"
  def authenticate, do: "authentication"
end
