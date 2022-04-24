defmodule ToReplaceWeb.Api.Auth do
  use ToReplaceWeb.Api.Base
  alias ToReplace.Repo
  alias ToReplace.Account
  alias ToReplace.Account.User
  alias ToReplace.Account.TokenGenerator
  alias ToReplace.Account.Token

  def me(%{assigns: %{current_user: %{id: _id} = me}} = conn, _params) do
    conn |> render("me.json", user: me)
  end

  def me(conn, _params) do
    conn |> unauthorized(:access_denied, "Please log in.")
  end

  def register(conn, %{"email" => _email, "password" => _password} = user_info) do
    case Account.create(user_info) do
      {:ok, user} ->
        conn |> login(user_info)

      err ->
        IO.puts("ERR > #{inspect(err)}")
        conn |> invalid("invalid_query", "invalid email or password")
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> not_found()

      %User{password: hashed_password} = user ->
        if Bcrypt.verify_pass(password, hashed_password) do
          {:ok, %Token{token: token}} = TokenGenerator.authorization(user)
          conn |> render("auth.json", %{user: user, token: token})
        else
          conn
          |> unauthorized()
        end
    end
  end

  def logout(conn, _params) do
    conn |> ok()
  end

  def fetch_current_user_from_headers(conn, _opts) do
    with {:ok, token} <- retrieve_token(get_req_header(conn, "authorization")),
         token_instance = %ToReplace.Account.Token{} <-
           ToReplace.Account.Token.get_by_token(token),
         {:ok, user} <-
           fetch_user(token_instance.user_id) do
      assign(conn, :current_user, user)
    else
      _ ->
        assign(conn, :current_user, nil)
    end
  end

  defp retrieve_token(["Bearer " <> token]) do
    {:ok, token}
  end

  defp retrieve_token(_), do: nil

  defp fetch_user(user_id) do
    case ToReplace.Account.get_by_id(user_id) do
      nil -> {:error, nil}
      user -> {:ok, user}
    end
  end
end
