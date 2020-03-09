defmodule Trustvox.Repo do
  use Ecto.Repo,
    otp_app: :trustvox,
    adapter: Ecto.Adapters.Postgres
end
