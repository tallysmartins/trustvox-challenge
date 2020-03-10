defmodule Companies.Companies do
  use ExUnit.Case
  use Trustvox.DataCase
  import TrustvoxWeb.TestHelpers
  alias Trustvox.Companies.{Companies, Company, Company.Subsidiary}
  alias Trustvox.Complains.Complains

  describe "create_company/1" do
    test "insert new company given correct params and one subsidiary" do
      subsidiaries = [%{city: "Sao Paulo", state: "SP"}]
      attrs = %{name: "trustvox", website: "trustvox.com", subsidiaries: subsidiaries}

      assert_difference(Company, 1) do
        assert_difference(Subsidiary, 1) do
          assert {:ok, company} = Companies.create_company(attrs)
          assert %Company{name: "trustvox", website: "trustvox.com"} = company
        end
      end
    end

    test "insert new company given correct params and multiple subsidiaries" do
      subsidiaries = [
        %{city: "Sao Paulo", state: "SP"},
        %{city: "Sao Paulo", state: "SP"}
      ]

      attrs = %{name: "trustvox", website: "trustvox.com", subsidiaries: subsidiaries}

      assert_difference(Company, 1) do
        assert_difference(Subsidiary, 2) do
          assert {:ok, company} = Companies.create_company(attrs)
          assert %Company{name: "trustvox", website: "trustvox.com"} = company
        end
      end
    end

    test "return invalid changeset when missing required fields" do
      assert {:error, changeset} = Companies.create_company(%{})

      assert %{
              name: ["can't be blank"],
              subsidiaries: ["can't be blank"]
            } = errors_on(changeset)
    end

    test "do not insert company if invalid subsidiary is given" do
      subsidiaries = [%{city: nil, state: nil}]
      attrs = %{name: "trustvox", website: "trustvox.com", subsidiaries: subsidiaries}
      assert_difference(Company, 0) do
        assert {:error, changeset} = Companies.create_company(attrs)
      end

      assert %{subsidiaries: [%{
                  city: ["can't be blank"],
                  state: ["can't be blank"]
              }]} = errors_on(changeset)
    end
  end

  describe "fetch_top_complained/1" do
    test "return top N complained companies" do
      c1 = create_company()
      c2 = create_company()
      c3 = create_company()

      generate_complains_for_subsidiary(3, hd(c1.subsidiaries)) |> Enum.map(&Complains.create_complain/1)
      generate_complains_for_subsidiary(1, hd(c2.subsidiaries)) |> Enum.map(&Complains.create_complain/1)
      generate_complains_for_subsidiary(2, hd(c3.subsidiaries)) |> Enum.map(&Complains.create_complain/1)

      [top1, top2] = Companies.fetch_top_complained(limit=2)
      assert [c1.id, c3.id] == [top1.id, top2.id]
    end
  end

  def create_company() do
    subsidiaries = [%{city: "Sao Paulo", state: "SP"}]
    attrs = %{name: "trustvox", website: "trustvox.com", subsidiaries: subsidiaries}

    Company.changeset(%Company{}, attrs)
    |> Repo.insert!()
  end

  def generate_complains_for_subsidiary(n, subsidiary)  do
    Enum.map(1..n, fn x ->
      %{title: "broken", description: "bad", subsidiary_id: subsidiary.id}
    end)
  end
end
