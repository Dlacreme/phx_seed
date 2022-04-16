defmodule ToReplace.Account.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tokens" do
    field :deprecated_at, :utc_datetime
    field :token, :string
    belongs_to :type, ToReplace.Account.TokenType, type: :string
    belongs_to :user, ToReplace.Account.User, type: :binary_id

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token, :type_id, :user_id, :deprecated_at])
    |> validate_required([:token, :type_id, :user_id, :deprecated_at])
  end
end
