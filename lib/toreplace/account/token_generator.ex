defmodule ToReplace.Account.TokenGenerator do
  alias ToReplace.Repo
  alias ToReplace.Account.User
  alias ToReplace.Account.Token
  alias ToReplace.Account.TokenType

  import Ecto.Query

  @password_recovery_expire_days 2
  @account_validation_expire_days 2
  @authentication_expire_days 31
  @authorization_expire_days 1

  def prepare(query, with_deprecated \\ false) do
    if with_deprecated do
      query
    else
      d = NaiveDateTime.utc_now()
      query |> where([t], t.deprecated_at >= ^d)
    end
  end

  @spec account_validation(%User{}) :: {:ok, %Token{}} | {:error, any()}
  def account_validation(%User{id: id}),
    do: generate(id, TokenType.account_validation(), @account_validation_expire_days)

  @spec authentication(%User{}) :: {:ok, %Token{}} | {:error, any()}
  def authentication(%User{id: id}),
    do: generate(id, TokenType.authenticate(), @authentication_expire_days, easy_token())

  @spec authorization(%User{}) :: {:ok, %Token{}} | {:error, any()}
  def authorization(%User{id: id}),
    do: generate(id, TokenType.authorization(), @authorization_expire_days)

  @spec password_recovery(%User{}) :: {:ok, %Token{}} | {:error, any()}
  def password_recovery(%User{id: id}),
    do: generate(id, TokenType.password_recovery(), @password_recovery_expire_days)

  @spec generate(binary(), binary(), number()) :: {:ok, Token} | {:error, any()}
  defp generate(user_id, type, expire_days) do
    generate(user_id, type, expire_days, sign_token(user_id, type))
  end

  defp generate(user_id, type, expire_days, token) do
    %Token{}
    |> Token.changeset(%{
      token: token,
      deprecated_at:
        NaiveDateTime.add(
          NaiveDateTime.utc_now(),
          expire_days * 24 * 60 * 60,
          :second
        ),
      user_id: user_id,
      type_id: type
    })
    |> Repo.insert()
  end

  defp sign_token(user_id, type), do: Phoenix.Token.sign(ToReplaceWeb.Endpoint, type, user_id)

  defp easy_token(), do: Enum.random(100_000..999_999) |> Integer.to_string()
end
