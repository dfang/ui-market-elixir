defmodule PragmaticWeb.Schema.ItemsTypes do
  use Absinthe.Schema.Notation

  object :item do
   
    field :title, :string
    field :cover, :string
    field :detail, :string
    field :zip, :string

    field :draft, :boolean
    field :featured, :boolean

    # belongs_to :category, Items
    # belongs_to :industry, Items

    # field :filetype, :map, default: %{}

    field :downloads, :integer
    field :likes, :integer
    field :views, :integer

  end
end
