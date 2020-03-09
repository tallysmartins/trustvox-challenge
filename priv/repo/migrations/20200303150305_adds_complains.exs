defmodule Trustvox.Repo.Migrations.AddsComplains do
  use Ecto.Migration

  def change do
    create table(:complains) do
      add :title, :string
      add :description, :string
      add :locale, :map

      timestamps()
    end
  end
end
