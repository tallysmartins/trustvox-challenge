defmodule Complains.ComplainsTest do
  use ExUnit.Case
  use Trustvox.DataCase
  import TrustvoxWeb.TestHelpers
  alias Trustvox.Complains.{Complains, Complain}
  alias Trustvox.Companies.Company

  describe "create_complain/2" do
    test "insert new Complain given correct params" do
      company = create_company()
      subsidiary = hd(company.subsidiaries)
      attrs = %{title: "broken", description: "broken"}

      assert_difference(Complain, 1) do
        assert {:ok, complain} = Complains.create_complain(attrs, subsidiary)
        assert %Complain{title: "broken", description: "broken"} = complain
      end
    end

    test "return foreign key constraint if subsidiary does not exist" do
      subsidiary = %{id: -99991} 
      attrs = %{title: "broken", description: "broken"}

      assert_difference(Complain, 0) do
        assert {:error, changeset} = Complains.create_complain(attrs, subsidiary)
        assert %{
                subsidiary_id: ["does not exist"]
              } = errors_on(changeset)
      end
    end
  end

  describe "create_complain/1" do
    test "return invalid changeset when missing required fields" do
      assert {:error, changeset} = Complains.create_complain(%{})
      assert %{
              description: ["can't be blank"],
              title: ["can't be blank"]
            } = errors_on(changeset)
    end
  end

  def create_company() do
    subsidiaries = [%{city: "Sao Paulo", state: "SP"}]
    attrs = %{name: "trustvox", website: "trustvox.com", subsidiaries: subsidiaries}

    Company.changeset(%Company{}, attrs)
    |> Repo.insert!()
  end
end
