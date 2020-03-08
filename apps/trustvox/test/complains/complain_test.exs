defmodule Complains.ComplainTest do
  use ExUnit.Case

  alias Trustvox.Complains.Complain

  @attrs %{
    "title" => "Some Title",
    "description" => "some description",
    "locale" => %{"street" => "some locale"},
    "company" => "some company",
  }

  describe "changeset/2" do
    test "be able to create Complain changeset object with correct attributes" do
      changeset = Complain.changeset(%Complain{}, @attrs)
      assert changeset.valid?
    end
  end
end
