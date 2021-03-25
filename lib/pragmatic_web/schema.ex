defmodule PragmaticWeb.Schema do
  use Absinthe.Schema
  import_types PragmaticWeb.Schema.ItemsTypes

  alias PragmaticWeb.Resolvers

  query do

    @desc "Get all items"
    field :items, list_of(:item) do
      resolve &Resolvers.Items.list_items/3
    end

  end

end