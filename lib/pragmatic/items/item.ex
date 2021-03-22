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

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :cover, :detail, :zip, :featured, :draft, :views, :downloads, :likes])
    |> validate_required([:title, :cover, :detail, :zip])
  end
end
