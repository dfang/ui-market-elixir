defmodule Pragmatic.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :cover, :string
    field :detail, :string
    field :zip, :string
    field :downloads, :integer
    field :draft, :boolean, default: false
    field :featured, :boolean, default: false
    field :likes, :integer
    field :title, :string
    field :views, :integer
    field :filetypes, {:array, :string}

    belongs_to :category, Pragmatic.Categories.Category
    belongs_to :industry, Pragmatic.Industries.Industry

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [
      :title,
      :cover,
      :detail,
      :zip,
      :featured,
      :draft,
      :views,
      :downloads,
      :likes,
      :category_id,
      :industry_id,
      :filetypes
    ])
    |> validate_required([:title, :cover, :detail, :zip])
  end
end
