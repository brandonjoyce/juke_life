defmodule JukeLife.Repo.Migrations.CreateJuke do
  use Ecto.Migration

  def change do
    create table(:jukes) do
      add :name, :string
      add :description, :string

      timestamps
    end

  end
end
