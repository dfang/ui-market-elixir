defmodule Pragmatic.Repo.Migrations.CreateFiletypes do
  use Ecto.Migration

  def change do
    create table(:filetypes) do
      add :ext, :string

      timestamps()
    end

  end
end
