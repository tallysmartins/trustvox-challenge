defmodule TrustvoxWeb.ComplainsController do
  use TrustvoxWeb, :controller
  alias Trustvox.Complains.{Complain}
  alias Trustvox.{Company, Repo}

  # FIXME paginate complains
  def index(conn, _params) do
    complains = Repo.all(Complain)
    render(
      conn,
      "list.html",
      complains: complains
    )
  end

  # FIXME fetch correct company and also list subsidiaries
  def new(conn, %{"company_id" => id} = _params) do
    company = Repo.all(Company) |> hd
    changeset = Complain.changeset(%Complain{}, %{})
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def new(conn, _params) do
    conn
    |> redirect(to: Routes.companies_path(conn, :search))
  end

  # FIXME create complain associated with subsidiary
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
