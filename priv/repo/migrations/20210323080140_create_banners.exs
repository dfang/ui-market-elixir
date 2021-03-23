defmodule Pragmatic.Repo.Migrations.CreateBanners do
  use Ecto.Migration

  def change do
    create table(:banners) do
      add :image, :string
      add :alt, :string
      add :position, :integer

      timestamps()
    end

  end
end
