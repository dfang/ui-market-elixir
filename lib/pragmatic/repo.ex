defmodule Pragmatic.Repo do
  use Ecto.Repo,
    otp_app: :pragmatic,
    adapter: Ecto.Adapters.Postgres
end
