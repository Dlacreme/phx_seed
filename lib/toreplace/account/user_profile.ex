defmodule ToReplace.Account.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToReplace.Validators

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_profiles" do
    field :name, :string
    field :phone_number, :string
    field :picture_url, :string

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:name, :picture_url, :phone_number])
    |> validate_required([])
    |> validate_phone_number()
  end

  defp validate_phone_number(changeset) do
    changeset
    |> validate_format(:phone_number, Validators.PhoneNumber.intl_phone_number_regex(),
      message: "invalid phone number"
    )
    |> unique_constraint(:phone_number)
  end
end
