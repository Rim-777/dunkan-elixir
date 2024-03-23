defmodule Dunkan.Repo do
  use Ecto.Repo,
    otp_app: :dunkan,
    adapter: Ecto.Adapters.Postgres
end
