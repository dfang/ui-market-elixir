defmodule PragmaticWeb.ItemLive do
  use PragmaticWeb, :live_view

  alias Pragmatic.Models.Item
  alias Pragmatic.Models.Category
  alias Pragmatic.Models.Industry
  alias Pragmatic.Models.Filetype


  def render(assigns) do
    ~L"""
    item detail page
    """
  end
end
