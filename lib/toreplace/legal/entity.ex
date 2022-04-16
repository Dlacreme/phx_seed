defmodule ToReplace.Legal.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "entities" do
    field :label, :string
    field :description, :string
    field :picture_url, :string
    field :disabled_at, :utc_datetime
    belongs_to :created_by, ToReplace.Account.User, type: :binary_id, foreign_key: :created_by_id

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:label, :picture_url, :created_by_id, :description, :disabled_at])
    |> validate_required([:label, :created_by_id])
  end
end
