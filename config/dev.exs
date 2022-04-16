import Config

# Configure your database
config :toreplace, ToReplace.Repo,
  username: System.get_env("POSTGRESQL_ADDON_USER", "postgres"),
  password: System.get_env("POSTGRESQL_ADDON_PASSWORD", "postgres"),
  database: System.get_env("POSTGRESQL_ADDON_DB", "toreplace_dev"),
  hostname: System.get_env("POSTGRESQL_ADDON_HOST", "localhost"),
  port: System.get_env("POSTGRESQL_ADDON_PORT", "5432"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  show_sensitive_data_on_connection_error: true

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :toreplace, ToReplaceWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "WQZ4kHG0cuEdvhY8qQ8q7tGdOC3t3E/L1stRI2cSUn3V53lJd71xzPZmXhzs3Zp6",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]},
    sass: {
      DartSass,
      :install_and_run,
      [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]
    }
  ]

# Watch static and templates for browser reloading.
config :toreplace, ToReplaceWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/toreplace_web/(live|views)/.*(ex)$",
      ~r"lib/toreplace_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
