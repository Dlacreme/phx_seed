defmodule ToReplace.Account do
  alias ToReplace.Repo
  alias ToReplace.Account.User
  alias ToReplace.Account.UserProfile

  def create(user_info) do
    with {:ok, %UserProfile{id: profile_id}} <- Repo.insert(%UserProfile{}),
         changeset <- User.changeset(%User{}, Map.merge(user_info, %{profile_id: profile_id})),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      err -> err
    end
  end
end
