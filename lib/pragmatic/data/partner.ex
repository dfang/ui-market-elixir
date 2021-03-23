defmodule Pragmatic.Data.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :image, :string
    field :name, :string
    field :positon, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :url, :image, :positon])
    |> validate_required([:name, :url, :image])
  end
end
