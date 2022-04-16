# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :toreplace,
  namespace: ToReplace,
  ecto_repos: [ToReplace.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :toreplace, ToReplaceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ToReplaceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ToReplace.PubSub,
  live_view: [signing_salt: "RMIqiEJO"]

# Configures the mailer
config :toreplace, ToReplace.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: System.get_env("MAILER_SECRET_KEY", "xxx"),
  domain: System.get_env("MAILER_DOMAIN", "yyy")

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, Swoosh.ApiClient.Finch

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.13.5",
  default: [
    args:
      ~w(ts/app.ts --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :dart_sass,
  version: "1.49.0",
  default: [
    args: ~w(scss/app.scss ../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

config :tailwind,
  version: "3.0.23",
  default: [
    args: ~w(
 --config=tailwind.config.js
 --input=scss/tailwind.css
 --output=../priv/static/assets/tailwind.css
 ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
