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


url = 'https://graphql.2mui.cn/v1/graphql'
data = '{
    "query": "{\n  items {\n    id\n    title\n    cover\n    detail\n    url\n  }\n}\n",
    "variables": null
}'
{:ok, response} = Tesla.post(url, data, headers: [{"content-type", "application/json"}])
{:ok, data} = response.body |> Jason.decode
items = data["data"]["items"]

use Pragmatic.Items.Item

for item <- items do
  IO.inspect item

  %Item{} |> 
      Item.changeset(Map.merge(item, %{"zip" => item["url"]})) |>
      Repo.insert()
end
