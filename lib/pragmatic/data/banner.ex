defmodule Pragmatic.Data.Banner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "banners" do
    field :alt, :string
    field :image, :string
    field :position, :integer

    timestamps()
  end

  @doc false
  def changeset(banner, attrs) do
    banner
    |> cast(attrs, [:image, :alt, :position])
    |> validate_required([:image, :alt])
  end
end
