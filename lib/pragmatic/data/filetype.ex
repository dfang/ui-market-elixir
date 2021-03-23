defmodule Pragmatic.Data.Filetype do
  use Ecto.Schema
  import Ecto.Changeset

  schema "filetypes" do
    field :ext, :string

    timestamps()
  end

  @doc false
  def changeset(filetype, attrs) do
    filetype
    |> cast(attrs, [:ext])
    |> validate_required([:ext])
  end
end
