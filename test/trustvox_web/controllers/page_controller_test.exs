defmodule TrustvoxWeb.PageControllerTest do
  use TrustvoxWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to TrustVox"
  end
end
