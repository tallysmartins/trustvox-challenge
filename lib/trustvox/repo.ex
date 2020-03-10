defmodule Trustvox.Repo do
  use Ecto.Repo,
    otp_app: :trustvox,
    adapter: Ecto.Adapters.Postgres

  def fetch(queryable, opts \\ []) do
    case one(queryable, opts) do
      nil -> {:error, :not_found}
      result -> {:ok, result}
    end
  end
end
