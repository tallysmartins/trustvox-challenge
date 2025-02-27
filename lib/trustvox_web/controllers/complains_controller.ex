defmodule TrustvoxWeb.ComplainsController do
  use TrustvoxWeb, :controller
  alias Trustvox.Complains.{Complains, Complain}
  alias Trustvox.Companies.Companies
  alias Trustvox.Repo

  # FIXME paginate complains
  def index(conn, _params) do
    complains = Complains.last_complains()
    render(
      conn,
      "list.html",
      complains: complains
    )
  end

  def new(conn, %{"company_id" => id}) do
    {:ok, company} = Companies.fetch_company(id)
    changeset = Complain.changeset(%Complain{}, %{})
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def new(conn, _params) do
    conn
    |> redirect(to: Routes.companies_path(conn, :search))
  end

  def create(conn, %{"complain" => params}) do
    Complains.create_complain(params)
    |> case do
      {:ok, _complain} ->
        conn
        |> put_flash(:info, "Complain created successfully.")
        |> redirect(to: Routes.complains_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Complain not created.")
        |> render(conn, "new.html", changeset: changeset)
    end
  end

  def stats(conn, _params) do
    render(conn, "stats.html")
  end
end
