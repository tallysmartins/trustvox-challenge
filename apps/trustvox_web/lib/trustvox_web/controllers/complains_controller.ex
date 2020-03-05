defmodule TrustvoxWeb.ComplainsController do
  use TrustvoxWeb, :controller
  alias Trustvox.Complains.{Complain}
  alias Trustvox.Repo

  def index(conn, _params) do
    # TODO paginate complains
    complains = Repo.all(Complain)
    render(
      conn,
      "list.html",
      complains: complains
    )
  end

  def new(conn, _params) do
    changeset = Complain.changeset(%Complain{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"complain" => params}) do
    %Complain{}
    |> Complain.changeset(params)
    |> Repo.insert()
    |> case do
      {:ok, complain} ->
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
