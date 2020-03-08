defmodule TrustvoxWeb.ComplainsControllerTest do
  use TrustvoxWeb.ConnCase
  import TrustvoxWeb.TestHelpers
  alias Trustvox.Complains.Complain

  @complain_params %{title: "Broken", description: "Not working"}

  describe "GET /complains/new" do
    test "redirect to search company page", %{conn: conn} do
      conn = get(conn, "/complains/new")

      assert redirected_to(conn) =~ "/search/companies"
    end
  end

  describe "POST /complains/create" do
    test "create complain when given correct params", %{conn: conn} do
      assert_difference(Complain, 1) do
        conn = post(conn, "/complains", %{complain: @complain_params})
      end
      assert get_flash(conn, :info) =~ "Complain created"
    end

    test "redirect to home after create", %{conn: conn} do
      conn = post(conn, "/complains", %{complain: @complain_params})
      assert redirected_to(conn)
    end
  end

  describe "GET /complains/" do
    test "display complains attributes", %{conn: conn} do
      {:ok, complain} = create_complain()
      {:ok, another_complain} = create_complain(%{@complain_params | title: "new title"})

      assert complain.title != another_complain.title

      conn = get(conn, "complains")

      assert html_response(conn, 200) =~ complain.title
      assert html_response(conn, 200) =~ complain.description
      assert html_response(conn, 200) =~ another_complain.title
      assert html_response(conn, 200) =~ another_complain.description
    end
  end

  def create_complain(params \\ @complain_params) do
    %Complain{}
    |> Complain.changeset(params)
    |> Trustvox.Repo.insert()
  end
end
