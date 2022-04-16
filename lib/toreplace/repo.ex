defmodule ToReplace.Repo do
  use Ecto.Repo,
    otp_app: :toreplace,
    adapter: Ecto.Adapters.Postgres
end
