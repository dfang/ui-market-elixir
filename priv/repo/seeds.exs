# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pragmatic.Repo.insert!(%Pragmatic.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pragmatic.Items.Item
alias Pragmatic.Items.Industry
alias Pragmatic.Items.Category
alias Pragmatic.Data.Filetype
alias Pragmatic.Repo
import Ecto.{Changeset, Query}

defmodule Myclient do
  use Tesla

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}, {"content-type", "application/json"}]

  @url("https://graphql.2mui.cn/v1/graphql")
  def post(query) do
    {:ok, response} = Tesla.post(@url, query)
    {:ok, data} = response.body |> Jason.decode()
    data["data"]
  end
end

items_query = '{
    "query": "{\n  items {\n    id\n    title\n    cover\n    detail\n    url\n  }\n}\n",
    "variables": null
}'
# {:ok, items} = Tesla.post(url, items_query, headers: [{"content-type", "application/json"}])
items = Myclient.post(items_query) |> Map.get("items")
for item <- items do
  %Item{}
    |> Item.changeset(Map.merge(item, %{"zip" => item["url"]}))
    |> Repo.insert()
end

categories_query = '{
    "query": "{ categories {    name description  }}",
    "variables": null
}'
categories = Myclient.post(categories_query) |> Map.get("categories")
for item <- categories do
  %Category{} |> Category.changeset(item) |> Repo.insert()
end


industries_query = '{
    "query": "{ industries {  name  }}",
    "variables": null
}'
industries = Myclient.post(industries_query) |> Map.get("industries")
for item <- industries do
  %Industry{} |> Industry.changeset(item) |> Repo.insert()
end

filetypes_query = '{
    "query": "{ filetypes {  ext  }}",
    "variables": null
}'
filetypes = Myclient.post(filetypes_query) |> Map.get("filetypes")
for item <- filetypes do
  %Filetype{} |> Filetype.changeset(item) |> Repo.insert()
end
