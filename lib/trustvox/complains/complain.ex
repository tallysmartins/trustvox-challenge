defmodule Trustvox.Complains.Complain do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Trustvox.Complains.Complain
  alias Trustvox.Companies.{Company, Company.Subsidiary}

  schema "complains" do
    field :title, :string
    field :description, :string
    field :locale, :map

    belongs_to :subsidiary, Subsidiary

    timestamps(type: :utc_datetime)
  end

  @fields [
    :title,
    :description,
    :locale,
    :subsidiary_id,
  ]

  def changeset(%Complain{} = complain, attrs) do
    complain
    |> cast(attrs, @fields)
    |> validate_required([:title, :description])
    |> foreign_key_constraint(:subsidiary_id)
    |> prepare_changes(&increment_subsidiary_complains_count/1)
    |> prepare_changes(&increment_company_complains_count/1)
  end


  defp increment_subsidiary_complains_count(%Ecto.Changeset{} = changeset) do
    if subsidiary_id = get_change(changeset, :subsidiary_id) do
      query =
       from s in Subsidiary,
         where: s.id == ^subsidiary_id
      changeset.repo.update_all(query, inc: [complains_count: 1])
    end
    changeset
  end

  defp increment_company_complains_count(%Ecto.Changeset{} = changeset) do
    if subsidiary_id = get_change(changeset, :subsidiary_id) do
      query =
       from c in Company,
         join: s in Subsidiary, where: s.id == ^subsidiary_id and c.id == s.company_id
      changeset.repo.update_all(query, inc: [complains_count: 1])
    end
    changeset
  end
end
