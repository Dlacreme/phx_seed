defmodule ToReplaceWeb.Api.Views.Auth do
  use ToReplaceWeb, :view

  def render("me.json", %{user: user}) do
    user
  end

  def render("auth.json", %{user: user, token: token}) do
    %{user: user, token: token}
  end
end
