defmodule Pragmatic.Repo.Migrations.CreatePartners do
  use Ecto.Migration

  def change do
    create table(:partners) do
      add :name, :string
      add :url, :string
      add :image, :string
      add :position, :integer

      timestamps()
    end
  end
end
