defmodule ToReplaceWeb.Controllers.Api.Base do
  @moduledoc """
  Main controller - provider common helpers
  """

  defmacro __using__(_) do
    quote do
      use ToReplaceWeb, :controller
      import Phoenix.Controller

      plug :put_view,
           Atom.to_string(__MODULE__)
           |> String.replace(".Controllers.", ".")
           |> Kernel.<>("View")
           |> String.to_atom()

      def error(conn, status, code, message) do
        conn
        |> put_status(status)
        |> put_view("ToReplaceWeb.Api.ErrorView")
        |> json(%{"code" => code, "message" => message})
        |> halt()
      end

      def invalid(conn, code, message) do
        conn |> error(400, code, message) |> halt()
      end

      def unauthorized(conn, code, message) do
        conn |> error(401, code, message) |> halt()
      end

      def not_found(conn, code, message) do
        conn |> error(404, code, message) |> halt()
      end
    end
  end
end
