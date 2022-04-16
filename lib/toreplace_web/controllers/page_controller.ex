defmodule ToReplaceWeb.PageController do
  use ToReplaceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
