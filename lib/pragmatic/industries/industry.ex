defmodule Pragmatic.Industries.Industry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "industries" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(industry, attrs) do
    industry
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
