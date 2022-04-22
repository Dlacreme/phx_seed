defmodule ToReplaceWeb.Api.Base do
  @moduledoc """
  Main controller - provider common helpers
  """

  defmacro __using__(_) do
    quote do
      use ToReplaceWeb, :controller
      import Phoenix.Controller

      plug :put_view,
           Atom.to_string(__MODULE__)
           |> String.replace(".Api.", ".Api.Views.")
           |> String.to_atom()

      def error(conn, status, code, message) do
        conn
        |> put_status(status)
        |> put_view("ToReplaceWeb.Api.ErrorView")
        |> json(%{"code" => code, "message" => message})
        |> halt()
      end

      def ok(conn) do
        conn |> json(%{"code" => "success", "message" => "ok"})
      end

      def invalid(conn, code, message) do
        conn |> error(400, code, message) |> halt()
      end

      def unauthorized(conn) do
        conn |> unauthorized(:access_denied, "Unauthorized")
      end

      def unauthorized(conn, code, message) do
        conn |> error(401, code, message) |> halt()
      end

      def not_found(conn) do
        conn |> not_found(:resource_not_found, "Resource not found")
      end

      def not_found(conn, code, message) do
        conn |> error(404, code, message) |> halt()
      end
    end
  end
end
