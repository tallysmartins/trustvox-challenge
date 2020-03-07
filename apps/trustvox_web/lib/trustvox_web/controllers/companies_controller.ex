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

  def create(conn, %{"company" => params}) do
    %Company{}
    |> Company.changeset(params)
    |> Repo.insert()
    |> case do
      {:ok, _company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.companies_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Company not created.")
        |> render(conn, "new.html", changeset: changeset)
    end
  end
end
