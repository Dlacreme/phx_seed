defmodule ToReplace.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string
    belongs_to :type, ToReplace.Account.UserType, type: :string
    belongs_to :profile, ToReplace.Account.UserProfile, type: :binary_id

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:type_id, :email, :profile_id, :password])
    |> validate_required([:type_id, :email, :profile_id])
    |> validate_email()
    |> validate_password()
  end

  @doc false
  def changeset_login(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
  end

  @doc false
  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "invalid email")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, ToReplace.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        changeset
        |> put_change(:password, Bcrypt.hash_pwd_salt(password))
    end
  end
end

defimpl Jason.Encoder, for: ToReplace.Account.User do
  def encode(value, opts) do
    Jason.Encode.map(
      Map.take(value, [:id, :email]),
      opts
    )
  end
end
