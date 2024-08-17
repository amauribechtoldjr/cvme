defmodule Cvme.Repo do
  use Ecto.Repo,
    otp_app: :cvme,
    adapter: Ecto.Adapters.Postgres
end
