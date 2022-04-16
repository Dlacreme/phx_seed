defmodule ToReplace.MixProject do
  use Mix.Project

  def project do
    [
      app: :toreplace,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  def application do
    [
      mod: {ToReplace.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Core
      {:plug_cowboy, "~> 2.5"},
      {:phoenix, "~> 1.6.4"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix_live_view, "~> 0.17.5"},
      # Database
      {:postgrex, ">= 0.0.0"},
      {:ecto_sql, "~> 3.6"},
      {:money, "~> 1.9"},
      # Api
      {:cors_plug, "~> 2.0"},
      # Mailing
      {:swoosh, "~> 1.3"},
      {:phoenix_swoosh, "~> 1.0"},
      {:finch, "~> 0.10"},
      # Format & validation
      {:bcrypt_elixir, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.0"},
      # i18n
      {:gettext, "~> 0.18"},
      # Front
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:dart_sass, "~> 0.4", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      # Formatter
      {:credo, "1.5.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      # Metrics
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "sass default --no-source-map --style=compressed",
        "phx.digest"
      ]
    ]
  end
end
