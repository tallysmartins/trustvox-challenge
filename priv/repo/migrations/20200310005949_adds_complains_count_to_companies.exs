defmodule Trustvox.Repo.Migrations.AddsComplainsCountToCompanies do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :complains_count, :integer, default: 0
    end
  end
end
