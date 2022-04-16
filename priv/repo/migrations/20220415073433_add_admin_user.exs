defmodule ToReplace.Repo.Migrations.AddAdminUser do
  use Ecto.Migration

  def change do
    ToReplace.Account.create(%{
      email: "admin@ToReplace.com",
      name: "Main admin",
      type_id: "admin",
      password: "password"
    })
  end
end
