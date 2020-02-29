defmodule Trustvox.Complains.Complain do
  use Ecto.Schema

  schema "complains" do
    field :title, :string
    field :description, :string
    field :locale, :string
    field :company, :string

    timestamps(type: :utc_datetime)
  end
end
