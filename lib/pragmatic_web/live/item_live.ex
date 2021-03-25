defmodule PragmaticWeb.ItemLive do
  use PragmaticWeb, :live_view

  alias Pragmatic.Items.Item
  alias Pragmatic.Items.Category
  alias Pragmatic.Items.Industry
  alias Pragmatic.Data.Filetype


  def render(assigns) do
    ~L"""
    item detail page
    """
  end
end
