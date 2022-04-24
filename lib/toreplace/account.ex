defmodule ToReplace.Account do
  alias ToReplace.Repo
  alias ToReplace.Account.User
  alias ToReplace.Account.UserProfile
  import Ecto.Query, only: [from: 2]

  def create(user_info) do
    with {:ok, %UserProfile{id: profile_id}} <- Repo.insert(%UserProfile{}),
         changeset <-
           User.changeset(
             %User{},
             Map.merge(user_info, %{"profile_id" => profile_id, "type_id" => "user"})
           ),
         {:ok, user} <- Repo.insert(changeset),
         any <- send_welcome_email(user) do
      IO.puts("ANY > #{inspect(any)}")
      {:ok, user}
    else
      err -> err
    end
  end

  def get_by_id(id) do
    from(u in User, where: u.id == ^id, join: u in assoc(u, :profile))
    |> Repo.one()
  end

  defp send_welcome_email(%User{email: email} = user) do
    %ToReplace.Notification.Recipient{
      email: email
    }
    |> ToReplace.Notification.send("to_replace - Welcome", "register.html", %{user: user})
  end
end
