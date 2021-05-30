defmodule Survfy.Repo do
  use Ecto.Repo,
    otp_app: :survfy,
    adapter: Ecto.Adapters.Postgres
end
