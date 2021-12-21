defmodule Pragmatic.Partners.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :image, :string
    field :name, :string
    field :position, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :url, :image, :position])
    |> validate_required([:name, :url, :image])
  end
end
