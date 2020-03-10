defmodule Trustvox.Companies.Companies do
  import Ecto.Query
  alias Trustvox.Companies.Company
  alias Trustvox.Repo

  def create_company(attrs) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def list_companies(limit \\ 100) when is_integer(limit) do
    Repo.all(from Company, limit: ^limit)
  end

  def fetch_company(id) do
    where(Company, id: ^id)
    |> preload(:subsidiaries)
    |> Repo.fetch()
  end

  # FIXME return fuzzy query, not exact one
  def search_by_name(name) do
    from(c in Company, where: c.name ==  ^name)
    |> Repo.all()
  end

  def fetch_top_complained(limit \\ 100) when is_integer(limit) do
    Company
    |> limit(^limit)
    |> order_by(desc: :complains_count)
    |> Repo.all()
  end
end
