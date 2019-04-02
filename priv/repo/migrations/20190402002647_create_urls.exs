defmodule Tiny.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :url, :string
      add :alias, :string
      add :counter, :integer, default: 0
      add :alive, :utc_datetime

      timestamps()
    end

    create unique_index(:urls, [:alias])

  end
end
