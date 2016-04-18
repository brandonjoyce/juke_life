defmodule JukeLife.Repo.Migrations.CreateSelection do
  use Ecto.Migration

  def change do
    create table(:selections) do
      add :url, :string
      add :played, :boolean, default: false
      add :juke_id, references(:jukes, on_delete: :nothing)

      timestamps
    end
    create index(:selections, [:juke_id])

  end
end
