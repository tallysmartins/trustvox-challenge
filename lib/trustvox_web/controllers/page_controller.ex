defmodule TrustvoxWeb.PageController do
  use TrustvoxWeb, :controller
  alias Trustvox.Companies.Companies
  alias Trustvox.Complains.Complains

  def index(conn, _params) do
    top_companies = Companies.fetch_top_complained(5)
    last_complains = Complains.last_complains(5)
    render(conn, "index.html", companies: top_companies, complains: last_complains)
  end
end
