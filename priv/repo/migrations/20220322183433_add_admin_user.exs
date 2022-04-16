defmodule ToReplace.Repo.Migrations.AddAdminUser do
  use Ecto.Migration

  def change do
    %ToReplace.Account.User{}
    |> ToReplace.Account.User.changeset(%{
      email: "admin@ToReplace.com",
      name: "Main admin",
      type_id: "admin"
    })
    |> ToReplace.Repo.insert!()
  end
end
