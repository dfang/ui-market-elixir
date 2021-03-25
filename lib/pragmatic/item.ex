defmodule Pragmatic.Item do
  import Ecto.Query, warn: false
  alias Pragmatic.Items.Item


  def list_items do
    Repo.all(Item)
  end

  def get_item!(id), do: Repo.get!(Item, id)

   def create_Item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def update_server(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  def change_Item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  
  defp base_query do
    from p in Item
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"category_id", category_id}, query) do
    if is_nil(category_id) do
      where(query, [i], category_id: is_nil(i.category_id))
    else
      where(query, [i], category_id: ^category_id)
    end
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  defp compose_query({"tags", tags}, query) do
    query
    |> join(:left, [p], t in assoc(p, :tags))
    |> where([_p, t], t.name in ^tags)
  end



end
