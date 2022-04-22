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
        conn |> render("auth.json", %{user: user, token: "xxx"})

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
end
