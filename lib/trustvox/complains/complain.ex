defmodule Trustvox.Complains.Complain do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trustvox.Complains.Complain

  schema "complains" do
    field :title, :string
    field :description, :string
    field :locale, :map

    belongs_to :subsidiary, Trustvox.Companies.Company.Subsidiary

    timestamps(type: :utc_datetime)
  end

  @fields [
    :title,
    :description,
    :locale,
  ]

  def changeset(%Complain{} = complain, attrs) do
    complain
    |> cast(attrs, @fields)
  end
end
