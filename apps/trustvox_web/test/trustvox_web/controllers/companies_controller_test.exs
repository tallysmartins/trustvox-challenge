defmodule TrustvoxWeb.CompaniesControllerTest do
  use TrustvoxWeb.ConnCase
  import TrustvoxWeb.TestHelpers
  alias Trustvox.{Company, Company.Subsidiary}

  @company_params %{name: "Trustvox", website: "trustvox.com"}
  @subsidiary_params %{city: "Sao Paulo", state: "SP"}
  @another_subsidiary_params %{city: "Brasilia", state: "DF"}

  describe "GET /companies/new" do
    test "display company input fields", %{conn: conn} do
      conn = get(conn, "/companies/new")
      assert html_response(conn, 200) =~ "Name"
      assert html_response(conn, 200) =~ "Website"
    end

    test "display subsidiary input fields", %{conn: conn} do
      conn = get(conn, "/companies/new")
      assert html_response(conn, 200) =~ "City"
      assert html_response(conn, 200) =~ "State"
    end
  end

  describe "POST /companies" do
    test "create company given correct fields and single subsidiary", %{conn: conn} do
      params = %{
        company: @company_params,
        subsidiaries: [@subsidiary_params]
      }

      assert_difference(Company, 1) do
        assert_difference(Subsidiary, 1) do
          conn = post(conn, "/companies", params)
        end
      end
    end

    test "create company given correct fields and multiple subsidiaries", %{conn: conn} do
      params = %{
        company: @company_params,
        subsidiaries: [@subsidiary_params, @another_subsidiary_params]
      }

      assert_difference(Company, 1) do
        assert_difference(Subsidiary, 2) do
          conn = post(conn, "/companies", params)
        end
      end
    end

    test "return friendly error if name field is empty", %{conn: conn} do
      params = %{
        company: %{@company_params | name: ""}, 
        subsidiaries: [@subsidiary_params]
      }

      conn = post(conn, "/companies", params)
      assert get_flash(conn, :error) =~ "Company not created"
    end

    test "do not create company if subsidiary is invalid", %{conn: conn} do
      params = %{
        company: @company_params, 
        subsidiaries: [%{}]
      }

      assert_difference(Company, 0) do
        assert_difference(Subsidiary, 0) do
          conn = post(conn, "/companies", params)
        end
      end
    end
  end
end
