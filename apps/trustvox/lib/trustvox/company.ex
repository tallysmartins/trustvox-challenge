
defmodule Trustvox.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trustvox.{Company, Company.Subsidiary}

  schema "company" do
    field :name, :string
    field :website, :string

    has_many :subsidiaries, Subsidiary

    timestamps(type: :utc_datetime)
  end


  defmodule Subsidiary do
    use Ecto.Schema

    schema "subsidiary" do
      field :city, :string
      field :state, :string

      has_many :complains, Trustvox.Complains.Complain
      belongs_to :company, Company
    end
  end

  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :website])
  end

  def changeset(%Subsidiary{} = subsidiary, attrs) do
    subsidiary
    |> cast(attrs, [:city, :state])
  end
end
