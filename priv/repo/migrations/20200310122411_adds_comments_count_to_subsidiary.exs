defmodule Trustvox.Repo.Migrations.AddsCommentsCountToSubsidiary do
  use Ecto.Migration

  def change do
    alter table(:subsidiaries) do
      add :complains_count, :integer, default: 0
    end
  end
end
