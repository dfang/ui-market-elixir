defmodule Pragmatic.Filetypes do
  @moduledoc """
  The Filetypes context.
  """

  import Ecto.Query, warn: false
  alias Pragmatic.Repo

  alias Pragmatic.Filetypes.Filetype

  @doc """
  Returns the list of filetypes.

  ## Examples

      iex> list_filetypes()
      [%Filetype{}, ...]

  """
  def list_filetypes do
    Repo.all(Filetype)
  end

  @doc """
  Gets a single filetype.

  Raises `Ecto.NoResultsError` if the Filetype does not exist.

  ## Examples

      iex> get_filetype!(123)
      %Filetype{}

      iex> get_filetype!(456)
      ** (Ecto.NoResultsError)

  """
  def get_filetype!(id), do: Repo.get!(Filetype, id)

  @doc """
  Creates a filetype.

  ## Examples

      iex> create_filetype(%{field: value})
      {:ok, %Filetype{}}

      iex> create_filetype(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_filetype(attrs \\ %{}) do
    %Filetype{}
    |> Filetype.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a filetype.

  ## Examples

      iex> update_filetype(filetype, %{field: new_value})
      {:ok, %Filetype{}}

      iex> update_filetype(filetype, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_filetype(%Filetype{} = filetype, attrs) do
    filetype
    |> Filetype.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a filetype.

  ## Examples

      iex> delete_filetype(filetype)
      {:ok, %Filetype{}}

      iex> delete_filetype(filetype)
      {:error, %Ecto.Changeset{}}

  """
  def delete_filetype(%Filetype{} = filetype) do
    Repo.delete(filetype)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking filetype changes.

  ## Examples

      iex> change_filetype(filetype)
      %Ecto.Changeset{data: %Filetype{}}

  """
  def change_filetype(%Filetype{} = filetype, attrs \\ %{}) do
    Filetype.changeset(filetype, attrs)
  end
end
