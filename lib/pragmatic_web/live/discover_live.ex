defmodule PragmaticWeb.DiscoverLive do
  use PragmaticWeb, :live_view

  alias Pragmatic.Items
  alias Pragmatic.Items.Item
  alias Pragmatic.Categories.Category
  alias Pragmatic.Industries.Industry
  alias Pragmatic.Filetypes.Filetype

  import Pragmatic.Repo
  import Ecto.{Changeset, Query}
  alias Pragmatic.Repo

  def mount(_params, _session, socket) do
    IO.inspect(self(), label: "MOUNT")

    socket =
      assign(socket,
        # type_options: type_options(),
        # industry_options: industry_options(),
        # format_options: format_options(),
        # sort_options: sort_options(),
        categories: categories(),
        industries: industries(),
        filetypes: filetypes(),
        sorts: sorts(),
        # defaults: defaults,
        category_id: 0,
        industry_id: 0,
        sort: 0,
        filetype: 0,
        items: Items.list_published_items()
      )

    {:ok, socket}
  end

  def handle_params(
        %{
          "category_id" => category_id,
          "industry_id" => industry_id,
          "filetype" => filetype,
          "sort" => sort
        },
        uri,
        socket
      ) do
    IO.puts("handle params")
    IO.puts("category_id: #{category_id}")
    IO.puts("industry_id: #{industry_id}")
    IO.puts("sort: #{sort}")
    IO.puts("filetype: #{filetype}")

    items =
      filter_items(%{
        category_id: category_id,
        industry_id: industry_id,
        filetype: filetype,
        sort: sort
      })

    # IO.inspect(items)
    socket =
      assign(socket,
        # category_id: category_id,
        # industry_id: industry_id,
        uri: URI.parse(uri),
        category_id: String.to_integer(category_id),
        industry_id: String.to_integer(industry_id),
        filetype: filetype,
        sort: String.to_integer(sort),
        items: items
        # filetype: ""
      )

    {:noreply, socket}
  end

  def handle_params(_, uri, socket) do
    IO.inspect(self(), label: "handle_params")

    {:noreply, assign(socket, uri: URI.parse(uri), filetype: "不限")}
  end

  defp categories do
    query = from c in Category, select: {c.id, c.name}
    # %{0 => "不限"} |> Enum.concat(Repo.all(query) |> Enum.into(%{}))
    Repo.all(query) |> Enum.into(%{}) |> Enum.concat(%{0 => "不限"}) |> Enum.sort()
  end

  defp industries do
    query = from c in Industry, select: {c.id, c.name}, limit: 10
    Repo.all(query) |> Enum.into(%{}) |> Enum.concat(%{0 => "不限"}) |> Enum.sort()
  end

  defp filetypes do
    query = from c in Filetype, select: {c.id, c.ext}, limit: 10
    Repo.all(query) |> Enum.into(%{}) |> Enum.concat(%{0 => "不限"}) |> Enum.sort()
  end

  defp sorts do
    [
      {0, "最新"},
      {1, "推荐"},
      {2, "最热"},
      {3, "下载量"}
    ]
  end

  # def handle_params(%{"category_id" => category_id}, _url, socket ) do
  #     IO.puts category_id
  #     # IO.puts industry_id
  #     IO.inspect socket.assigns
  #     socket = assign(socket, category_id: category_id)
  #     IO.inspect socket.assigns
  #     {:noreply, socket}
  # end

  # def handle_params(%{"industry_id" => industry_id}, _url, socket ) do
  #     IO.puts industry_id
  #     # IO.puts industry_id
  #     # IO.inspect socket.assigns
  #     socket = assign(socket, industry_id: industry_id)
  #     # IO.inspect socket.assigns

  #     # socket =
  #     #   push_patch(socket,
  #     #     to:
  #     #       Routes.live_path(
  #     #         socket,
  #     #         __MODULE__,
  #     #         category_id: socket.assigns.category_id,
  #     #         industry_id: industry_id
  #     #       )
  #     #   )

  #     {:noreply, socket}
  # end

  defp filter_items(%{
         category_id: category_id,
         industry_id: industry_id,
         filetype: filetype,
         sort: sort
       }) do
    # base_query = from i in Item
    IO.inspect(self(), label: "filter items")
    IO.puts("industry_id: #{industry_id}")
    IO.puts("category_id: #{category_id}")
    IO.puts("filetype: #{filetype}")

    IO.puts(is_integer(industry_id))
    IO.puts(inspect(industry_id))

    query = Item

    query =
      if category_id == "0" || is_nil(category_id) do
        IO.puts("category_id == 0")
        query
      else
        from(query |> where([x], x.category_id == ^category_id))
      end

    query =
      if industry_id == "0" || is_nil(industry_id) do
        IO.puts("industry_id == 0")
        query
      else
        from(query |> where([x], x.industry_id == ^industry_id))
      end

    query =
      if filetype == "不限" || is_nil(filetype) do
        query
      else
        # query
        # select filetype from items where filetype::jsonb ?| array['PNG'];
        # eg. select filetype from items where filetype::jsonb ?| array['PNG'];
        # form(query |> where([x], fragment("filetype::jsonb ?| array['PNG']") ))
        # type(^"\"green\"", :string)
        # filetypes = ["AI"]
        from p in query,
          where: ^filetype in p.filetypes

        # where: fragment("(filetypes) @> ?", ^filetypes)
      end

    # {0, "最新"},
    # {1, "推荐"},
    # {2, "最热"},
    # {3, "下载量"}
    order =
      case sort do
        "0" -> :inserted_at
        "1" -> :featured
        "2" -> :likes
        "3" -> :downloads
        _ -> :inserted_at
      end

    IO.puts(order)

    query = from query, order_by: [desc: ^order]
    results = query |> Repo.all()

    # conditions = false
    # conditions = if category_id == 0 || is_nil(category_id) do
    #     conditions
    # else
    #     dynamic([p], p.category_id == 4 or ^conditions)
    # end

    # conditions = if industry_id == 0 || is_nil(industry_id) do
    #     conditions
    # else
    #     dynamic([p], p.industry_id == 7 and ^conditions)
    # end

    # # {0, "最新"},
    # # {1, "推荐"},
    # # {2, "最热"},
    # # {3, "下载量"}
    # order = case sort do
    #   0 -> :inserted_at
    #   1 -> :featured
    #   2 -> :likes
    #   3 -> :downloads
    #   _ -> :inserted_at
    # end

    # from i in Item, where: ^conditions, order_by: [desc: ^order]
  end

  # defp filter_items(%{category_id: category_id, industry_id: industry_id, sort: sort}) do
  #   IO.puts "order"
  #   IO.puts order

  #   base_query = from i in Item
  #   base_query |> 
  #         Items.build_query(category_id: category_id) |>
  #         Items.build_query(industry_id: industry_id) |>
  #         # where([i], category_id: ^category_id) |>
  #         # where([i], industry_id: ^industry_id) |>
  #         order_by(desc: ^order) |>
  #         Repo.all
  # end
end
