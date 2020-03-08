defmodule TrustvoxWeb.CompaniesController do
  use TrustvoxWeb, :controller
  alias Trustvox.Company
  alias Trustvox.Repo

  def index(conn, _params) do
    # TODO paginate companies
    companies = Repo.all(Company)
    render(
      conn,
      "list.html",
      companies: companies
    )
  end

  def new(conn, _params) do
    changeset = Company.changeset(%Company{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  # FIXME allow to create multiple subsidiaries
  def create(conn, %{"company" => company, "subsidiary" => subsidiary}) do
    %Company{}
    |> Company.changeset(company)
    |> Repo.insert()
    |> case do
      {:ok, _company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.companies_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Company not created.")
        |> render("new.html", changeset: changeset)
    end
  end

  # FIXME redirect to :back_to, otherwise go to show company page
  def search(conn, params) do
    case get_in(params, ["search", "query"]) do
      nil ->
        companies = Company.fetch_last_complained()
        render(conn, "search_form.html", companies: companies)
      query ->
        companies = Company.fetch_by_name_like(query)
        render(conn, "list.html", companies: companies)
    end
  end
end
