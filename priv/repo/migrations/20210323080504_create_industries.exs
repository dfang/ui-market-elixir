defmodule Pragmatic.Repo.Migrations.CreateIndustries do
  use Ecto.Migration

  def change do
    create table(:industries) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
