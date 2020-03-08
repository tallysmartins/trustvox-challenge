defmodule TrustvoxWeb.ComplainsController do
  use TrustvoxWeb, :controller
  alias Trustvox.Complains.{Complain}
  alias Trustvox.{Company, Repo}

  def index(conn, _params) do
    # TODO paginate complains
    complains = Repo.all(Complain)
    render(
      conn,
      "list.html",
      complains: complains
    )
  end

  def new(conn, %{"company_id" => id} = params) do
    company = Repo.one(Company, id: id)
    changeset = Company.changeset(%Company{}, %{})
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def new(conn, params) do
    conn
    |> redirect(to: Routes.companies_path(conn, :search))
  end

  def create(conn, %{"complain" => params}) do
    %Complain{}
    |> Complain.changeset(params)
    |> Repo.insert()
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
