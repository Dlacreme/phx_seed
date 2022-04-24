defmodule ToReplaceWeb.Router do
  use ToReplaceWeb, :router
  import ToReplaceWeb.Controllers.Auth
  import ToReplaceWeb.Api.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ToReplaceWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user_from_cookies
  end

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
    plug :fetch_current_user_from_headers
  end

  scope "/", ToReplaceWeb do
    pipe_through :browser

    get "/", Controllers.Page, :index
    get "/login", Controllers.Auth, :index
    post "/login", Controllers.Auth, :login
    get "/logout", Controllers.Auth, :logout
    post "/register", Controllers.Auth, :register
    put "/register", Controllers.Auth, :register
  end

  scope "/api", ToReplaceWeb.Api do
    pipe_through :api

    get "/me", Auth, :me
    post "/login", Auth, :login
    post "/register", Auth, :register
    delete "/logout", Auth, :logout
  end

  scope "/admin", TTWeb do
    pipe_through [:browser, :require_authenticated_admin]

    import Phoenix.LiveDashboard.Router
    live_dashboard "/telemetry", metrics: ToReplaceWeb.Telemetry
  end

  # Enables the Swoosh mailbox preview in development.
  # (only display email from same node)
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
