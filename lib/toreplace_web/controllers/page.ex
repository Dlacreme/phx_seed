defmodule ToReplaceWeb.Controllers.Page do
  use ToReplaceWeb.Controllers.Base

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
