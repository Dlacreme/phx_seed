defmodule ToReplaceWeb.Controllers.Base do
  defmacro __using__(_) do
    quote do
      use ToReplaceWeb, :controller
      import Phoenix.Controller

      plug :put_view,
           Atom.to_string(__MODULE__)
           |> String.replace(".Controllers.", ".")
           |> Kernel.<>("View")
           |> String.to_atom()

      def not_found(conn) do
        conn
        |> put_view(ToReplaceWeb.ErrorView)
        |> render("404.html")
        |> halt()
      end
    end
  end
end
