defmodule PragmaticWeb.DiscoverLive do
  use PragmaticWeb, :live_view

  alias Pragmatic.Items.Item
  alias Pragmatic.Items.Category
  alias Pragmatic.Items.Industry
  alias Pragmatic.Data.Filetype

  import Pragmatic.Repo
  import Ecto.{Changeset, Query}
  alias Pragmatic.Repo

  def mount(_params, _session, socket) do
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
        filetype: 0,
        sort: 0,
        items: []
      )

    {:ok, socket}
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

  def handle_params(%{"category_id" => category_id, "industry_id" => industry_id, "sort" => sort}, _url, socket ) do
    IO.puts "params"
    IO.puts category_id
    IO.puts industry_id
    IO.puts sort
    items = filter_items(%{category_id: category_id, industry_id: industry_id, sort: sort})
    # IO.inspect(items)
    socket =
      assign(socket,
        # category_id: category_id,
        # industry_id: industry_id,

        category_id: String.to_integer(category_id),
        industry_id: String.to_integer(industry_id),
        # filetype: String.to_integer(filetype),
        sort: String.to_integer(sort),
        items: items,
        filetype: "",
      )

    {:noreply, socket}
  end

  def handle_params(_, _url, socket) do
    {:noreply, socket}
  end

  defp filter_items(%{category_id: category_id, industry_id: industry_id, sort: sort}) do
    if category_id == 0 do
      category_id = nil
    end

    if industry_id == 0 do
      industry_id = nil
    end
    # {0, "最新"},
    # {1, "推荐"},
    # {2, "最热"},
    # {3, "下载量"}
    order = case sort do
      0 -> :inserted_at
      1 -> :featured
      2 -> :likes
      3 -> :downloads
      _ -> :inserted_at
    end

    IO.puts "order"
    IO.puts order
    
    base_query = from i in Item
    base_query |> 
          where([i], category_id: ^category_id) |>
          where([i], industry_id: ^industry_id) |>
          order_by(desc: ^order) |>
          Repo.all
  end
end
