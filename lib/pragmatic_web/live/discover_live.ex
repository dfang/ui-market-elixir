defmodule PragmaticWeb.DiscoverLive do
  use PragmaticWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        type_options: type_options(),
        industry_options: industry_options(),
        format_options: format_options(),
        sort_options: sort_options()
      )

    {:ok, socket}
  end

  # def render(assigns) do
  #   ~L"""
  #   discover
  #   """
  # end

  def handle_event(
        "filter",
        %{"format" => format, "type" => type, "industry" => industry, "sort" => sort},
        socket
      ) do
    IO.puts(type)
    IO.puts(format)
    IO.puts(industry)
    IO.puts(sort)
    # IO.puts params
    {:noreply, socket}
  end

  defp price_radio(assigns) do
    assigns = Enum.into(assigns, %{})

    ~L"""
    <input type="radio" id="<%= @price %>"
           name="prices[]" value="<%= @price %>"
           <%= if @checked, do: "checked" %>/>
    <label for="<%= @price %>"><%= @price %></label>
    """
  end

  defp type_options do
    a = [
      "不限",
      "UI",
      "图标",
      "背景",
      "插画",
      "平面广告",
      "动效",
      "3D"
    ]

    0..length(a) |> Enum.map(fn x -> x end) |> Enum.zip(a) |> Enum.into(%{})
  end

  defp industry_options do
    a = [
      "不限",
      "电商微商",
      "IT互联网",
      "地产家居",
      "政府公益",
      "教育培训",
      "文化娱乐",
      "酒店旅游",
      "医疗医药",
      "生活服务",
      "美容健身"
    ]

    0..length(a) |> Enum.map(fn x -> x end) |> Enum.zip(a) |> Enum.into(%{})
  end

  defp format_options do
    a = [
      "不限",
      "PSD",
      "AI",
      "XD",
      "Sketch",
      "EPS",
      "C4D",
      "HTML",
      "AEP",
      "JPG",
      "PNG",
      "Figma",
      "MAX",
      "OBJ",
      "MA"
    ]

    0..length(a) |> Enum.map(fn x -> x end) |> Enum.zip(a) |> Enum.into(%{})
  end

  defp sort_options do
    a = [
      "最新",
      "推荐",
      "最热",
      "下载量"
    ]

    0..length(a) |> Enum.map(fn x -> x end) |> Enum.zip(a) |> Enum.into(%{})
  end
end
