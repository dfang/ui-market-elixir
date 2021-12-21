defmodule Pragmatic.Industries do
  @moduledoc """
  The Industries context.
  """

  import Ecto.Query, warn: false
  alias Pragmatic.Repo

  alias Pragmatic.Industries.Industry

  @doc """
  Returns the list of industries.

  ## Examples

      iex> list_industries()
      [%Industry{}, ...]

  """
  def list_industries do
    Repo.all(Industry)
  end

  @doc """
  Gets a single industry.

  Raises `Ecto.NoResultsError` if the Industry does not exist.

  ## Examples

      iex> get_industry!(123)
      %Industry{}

      iex> get_industry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_industry!(id), do: Repo.get!(Industry, id)

  @doc """
  Creates a industry.

  ## Examples

      iex> create_industry(%{field: value})
      {:ok, %Industry{}}

      iex> create_industry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_industry(attrs \\ %{}) do
    %Industry{}
    |> Industry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a industry.

  ## Examples

      iex> update_industry(industry, %{field: new_value})
      {:ok, %Industry{}}

      iex> update_industry(industry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_industry(%Industry{} = industry, attrs) do
    industry
    |> Industry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a industry.

  ## Examples

      iex> delete_industry(industry)
      {:ok, %Industry{}}

      iex> delete_industry(industry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_industry(%Industry{} = industry) do
    Repo.delete(industry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking industry changes.

  ## Examples

      iex> change_industry(industry)
      %Ecto.Changeset{data: %Industry{}}

  """
  def change_industry(%Industry{} = industry, attrs \\ %{}) do
    Industry.changeset(industry, attrs)
  end
end
