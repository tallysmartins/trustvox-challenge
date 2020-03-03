defmodule Complains.ComplainTest do
  alias Trustvox.Complains.Complain

  @attrs %{
    "title" => "Some Title",
    "description" => "some description",
    "locale" => "some locale",
    "company" => "some company",
  }

  describe "changeset/2" do
    test "validade required fields" do
      changeset = Complain.changeset(%Complain{}, @attrs)
      assert changeset.valid?

      changeset = Complain.changeset(%Complain{}, %{@attrs | "title" => ""})
      assert changeset.valid?
    end
  end

  test " dasda" do
    assert false
  end
end
