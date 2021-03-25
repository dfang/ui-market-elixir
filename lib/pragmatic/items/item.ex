defmodule Pragmatic.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :cover, :string
    field :detail, :string
    field :downloads, :integer
    field :draft, :boolean, default: false
    field :featured, :boolean, default: false
    field :likes, :integer
    field :title, :string
    field :views, :integer
    field :zip, :string

    belongs_to :category, Items
    belongs_to :industry, Items
    field :filetype, :map, default: %{}

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :cover, :detail, :zip, :featured, :draft, :views, :downloads, :likes, :category_id, :industry_id])
    |> validate_required([:title, :cover, :detail, :zip])
  end
end
