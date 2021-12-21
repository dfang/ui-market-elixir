defmodule Pragmatic.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias Pragmatic.Repo

  alias Pragmatic.Items.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  def list_published_items do
    query = from(i in Item, where: i.draft == false, limit: 30)
    Repo.all(query)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  def filter_by_params(%{category_id: category_id, industry_id: industry_id}) do
    query = from(i in Item)
    conditions = false

    conditions =
      if category_id == 0 || is_nil(category_id) do
        conditions
      else
        dynamic([p], p.category_id == ^category_id or ^conditions)
      end

    conditions =
      if industry_id == 0 || is_nil(industry_id) do
        conditions
      else
        dynamic([p], p.industry_id == ^industry_id and ^conditions)
      end

    from query, where: ^conditions
  end

  # def filter(filter) do
  #   from(i in Item)
  #     |> maybe_filter_by("artist", filter["artist"])
  #     |> maybe_filter_by("year", filter["year"])
  #     |> maybe_filter_by("language", filter["language"])
  #     |> Repo.all()
  # end

  # @allowed_fields ~w{draft featured category_id industry_id}
  # defp maybe_filter_by(query, _field, nil), do: query
  # defp maybe_filter_by(query, field, value) when field in @allowed_fields do
  #   field = String.to_existing_atom(field)
  #   query |> 
  #     where([s], field(s, ^field) == ^value)
  # end

  defp base_query do
    from(p in Item)
  end

  def build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query(_, query), do: query

  defp compose_query(%{category_id: category_id}, query) do
    IO.puts(category_id)

    if is_nil(category_id) or category_id == 0 do
      # where(query, [i], category_id: is_nil(i.category_id))
      query
    else
      where(query, [i], category_id: ^category_id)
    end
  end

  defp compose_query(%{industry_id: industry_id}, query) do
    IO.puts(industry_id)

    if is_nil(industry_id) or industry_id == 0 do
      # where(query, [i], category_id: is_nil(i.category_id))
      query
    else
      where(query, [i], industry_id: ^industry_id)
    end
  end

  # def drafts, do: all(%{"draft" => true})
  # def published, do: all(%{"draft" => false})
end
