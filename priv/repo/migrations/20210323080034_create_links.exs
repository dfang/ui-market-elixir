defmodule Pragmatic.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :name, :string
      add :url, :string
      add :position, :integer

      timestamps()
    end

  end
end
