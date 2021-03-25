defmodule PragmaticWeb.Resolvers.Items do
  alias Pragmatic.Repo
  alias Pragmatic.Models.Item

  def list_items(_parent, _args, _resolution) do
    {:ok, Repo.all(Item)}
  end

end
