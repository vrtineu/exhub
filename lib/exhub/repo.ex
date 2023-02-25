defmodule Exhub.Repo do
  use Ecto.Repo,
    otp_app: :exhub,
    adapter: Ecto.Adapters.Postgres
end
