defmodule Trustvox.Complains.Complain do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trustvox.Complains.Complain
  alias Trustvox.Companies.Company.Subsidiary

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
  end
end
