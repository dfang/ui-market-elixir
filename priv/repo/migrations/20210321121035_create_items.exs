defmodule Pragmatic.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string
      add :cover, :string
      add :detail, :string
      add :zip, :string
      add :featured, :boolean, default: false, null: false
      add :draft, :boolean, default: false, null: false
      add :views, :integer
      add :downloads, :integer
      add :likes, :integer
      add :filetypes, {:array, :string}

      add :category_id, :integer
      add :industry_id, :integer

      timestamps()
    end
  end
end
