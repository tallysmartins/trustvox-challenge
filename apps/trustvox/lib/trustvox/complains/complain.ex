defmodule Trustvox.Complains.Complain do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trustvox.Complains.Complain

  schema "complains" do
    field :title, :string
    field :description, :string
    field :locale, :string
    field :company, :string

    timestamps(type: :utc_datetime)
  end

  @fields [
    :title,
    :description,
    :locale,
    :company,
  ]

  @required_fields @fields -- [:locale, :company]
  def changeset(%Complain{} = complain, attrs) do
    complain
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
