defmodule Pragmatic.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :name, :string
    field :position, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:name, :url, :position])
    |> validate_required([:name, :url])
  end
end
