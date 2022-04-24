defmodule ToReplaceWeb.Controllers.Auth do
  use ToReplaceWeb.Controllers.Base

  alias ToReplace.Repo
  alias ToReplace.Account.TokenGenerator
  alias ToReplace.Account.Token
  alias ToReplace.Account.User
  alias ToReplace.Account.UserType

  @max_age 60 * 60 * 24 * 60
  @remember_me_cookie "_to_replace_web_user_remember_me"
  @remember_me_options [sign: true, max_age: @max_age, same_site: "Lax"]

  @max_age 60 * 60 * 24 * 60
  @remember_me_cookie "_pt_web_user_remember_me"
  @remember_me_options [sign: true, max_age: @max_age, same_site: "Lax"]

  def index(%{assigns: %{current_user: user}} = conn, _params) when user != nil do
    conn |> redirect(to: Routes.page_path(conn, :index))
  end

  def index(conn, _params) do
    conn
    |> render(:index,
      register_changeset: User.changeset(%User{}, %{type_id: "user"}),
      login_changeset: User.changeset(%User{}, %{})
    )
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> put_flash(:error, ToReplaceWeb.Gettext.gettext("unknown account"))
        |> redirect(to: Routes.auth_path(conn, :index))

      %User{password: hashed_password} = user ->
        if Bcrypt.verify_pass(password, hashed_password) do
          {:ok, %Token{token: token}} = TokenGenerator.authorization(user)
          conn |> authenticate(token) |> redirect(to: Routes.page_path(conn, :index))
        else
          conn
          |> put_flash(:error, ToReplaceWeb.Gettext.gettext("invalid email or password"))
          |> redirect(to: Routes.auth_path(conn, :index))
        end
    end
  end

  def logout(%{assigns: %{current_user: _user}} = conn, _params) do
    user_token = get_session(conn, :user_token)

    IO.puts("SHOULD REMOVE #{user_token}")

    if live_socket_id = get_session(conn, :live_socket_id) do
      ToReplaceWeb.Endpoint.broadcast(live_socket_id, "disconnect", %{})
    end

    Token

    conn
    |> renew_session()
    |> delete_resp_cookie(@remember_me_cookie)
    |> redirect(to: Routes.auth_path(conn, :index))
  end

  def logout(conn, _params) do
    conn |> redirect(to: Routes.auth_path(conn, :index))
  end

  defp authenticate(conn, authorization_token) do
    conn
    |> renew_session()
    |> put_session(:user_token, authorization_token)
    |> put_session(:live_socket_id, "users_session:#{Base.url_encode64(authorization_token)}")
    |> write_cookies(authorization_token)
    |> put_flash(:info, ToReplaceWeb.Gettext.gettext("welcome back"))
  end

  defp write_cookies(conn, token) do
    put_resp_cookie(conn, @remember_me_cookie, token, @remember_me_options)
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end

  # PLUGS
  def fetch_current_user_from_cookies(conn, _opts) do
    {conn, token} = conn |> retrieve_token()

    if token != nil do
      case Token |> TokenGenerator.prepare() |> Repo.get_by(token: token) do
        nil ->
          assign(conn, :current_user, nil)

        %Token{user_id: user_id} ->
          assign(conn, :current_user, Repo.get_by(User, id: user_id))
      end
    else
      assign(conn, :current_user, nil)
    end
  end

  def require_authenticated_user(conn, _opts) do
    if Map.has_key?(conn.assigns, :current_user) &&
         Map.fetch!(conn.assigns, :current_user) != nil do
      conn
    else
      conn |> not_found()
    end
  end

  def require_authenticated_admin(conn, _opts) do
    require_authenticate_types(conn, [UserType.admin()])
  end

  defp require_authenticate_types(conn, types) do
    if Map.has_key?(conn.assigns, :current_user) && Map.fetch!(conn.assigns, :current_user) != nil do
      user = Map.fetch!(conn.assigns, :current_user)

      if user.type_id in types do
        conn
      else
        conn
        |> not_found()
      end
    else
      conn
      |> not_found()
    end
  end

  defp retrieve_token(conn) do
    if user_token = get_session(conn, :user_token) do
      {conn, user_token}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if user_token = conn.cookies[@remember_me_cookie] do
        {put_session(conn, :user_token, user_token), user_token}
      else
        {conn, nil}
      end
    end
  end
end
