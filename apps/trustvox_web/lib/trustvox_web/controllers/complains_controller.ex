defmodule TrustvoxWeb.ComplainsController do
  use TrustvoxWeb, :controller
  alias Trustvox.Complains.{Complains, Complain}
  alias Trustvox.Repo

  def index(conn, _params) do
    # TODO paginate complains
    complains = Repo.all(Complain)
    render(
      conn,
      "list.html",
      complains: complains,
    )
  end

  def new(conn, params) do
    changeset = Complain.changeset(%Complain{}, %{})
    render(conn, "new.html", changeset: changeset)
  end
end
