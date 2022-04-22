defmodule ToReplaceWeb.Api.Views.Auth do
  use ToReplaceWeb, :view

  def render("me.json", user) do
    %{ok: true}
  end
end
