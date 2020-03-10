defmodule Trustvox.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Trustvox.Companies.{Company, Company.Subsidiary}
  alias Trustvox.Repo

  schema "companies" do
    field :name, :string
    field :website, :string
    field :complains_count, :integer

    has_many :subsidiaries, Subsidiary

    timestamps(type: :utc_datetime)
  end

  defmodule Subsidiary do
    use Ecto.Schema

    schema "subsidiaries" do
      field :city, :string
      field :state, :string

      has_many :complains, Trustvox.Complains.Complain
      belongs_to :company, Company

      timestamps(type: :utc_datetime)
    end

    def changeset(%Subsidiary{} = subsidiary, attrs) do
      subsidiary
      |> cast(attrs, [:city, :state])
      |> validate_required([:city, :state])
    end
  end

  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :website])
    |> validate_required([:name])
    |> cast_assoc(:subsidiaries, required: true, with: &Subsidiary.changeset/2)
  end


  # FIXME return fuzzy query, not exact one
  def fetch_by_name_like(name) do
    from(c in Company, where: c.name ==  ^name)
    |> Repo.all()
  end

  # FIXME query last complained not only last ones
  def fetch_last_complained(limit \\ 10) do
    Company
    |> limit(^limit)
    |> Repo.all()
  end
end
