defmodule Trustvox.Repo.Migrations.AddsCompanyAndSubsidiaryTables do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string, null: false
      add :website, :string

      timestamps()
    end

    create table(:subsidiaries) do
      add :city, :string
      add :state, :string
      add :company_id, references(:companies), null: false

      timestamps()
    end
  end
end
