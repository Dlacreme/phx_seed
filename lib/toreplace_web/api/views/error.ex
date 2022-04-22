defmodule ToReplaceWeb.Api.ErrorView do
  use ToReplaceWeb, :view

  def render("error.json", %{"code" => _code, "message" => _msg} = error) do
    error
  end
end
