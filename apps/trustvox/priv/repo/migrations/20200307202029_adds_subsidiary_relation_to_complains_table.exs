defmodule Trustvox.Repo.Migrations.AddsSubsidiaryRelationToComplainsTable do
  use Ecto.Migration

  def change do
    alter table(:complains) do
      add :subsidiary_id, references(:subsidiaries)
    end
  end
end
