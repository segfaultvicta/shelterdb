defmodule Shelterdb.Repo do
  use Ecto.Repo,
    otp_app: :shelterdb,
    adapter: Ecto.Adapters.Postgres
end
