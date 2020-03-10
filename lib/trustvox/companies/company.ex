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
      |> validate_state(:state)
    end

    def validate_state(changeset, field, options \\ []) do
      validate_change(changeset, field, fn _, state ->
        case state in valid_states() do
          true -> []
          false -> [{field, options[:message] || "invalid state"}]
        end
      end)
    end

    def valid_states() do
      ~w(AC AL AP AM BA CE DF ES GO MA MT MS MG PA
            PB PR PE PI RJ RN RS RO RR SC SP SE TO)
    end
  end

  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :website])
    |> validate_required([:name])
    |> cast_assoc(:subsidiaries, required: true, with: &Subsidiary.changeset/2)
  end

  def create_changeset() do
    %Company{subsidiaries: [%Subsidiary{state: "AC", city: ""}]}
    |> cast(%{}, [])
  end


  # FIXME return fuzzy query, not exact one
  def fetch_by_name_like(name) do
    from(c in Company, where: c.name ==  ^name)
    |> Repo.all()
  end
end
