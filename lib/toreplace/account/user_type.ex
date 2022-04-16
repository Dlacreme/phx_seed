defmodule ToReplace.Account.UserType do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "user_types" do
    field :label, :string
  end

  def user(), do: "user"
  def admin(), do: "admin"
end
