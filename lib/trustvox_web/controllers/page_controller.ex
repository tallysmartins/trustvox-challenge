defmodule TrustvoxWeb.PageController do
  use TrustvoxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
