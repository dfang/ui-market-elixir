defmodule PragmaticWeb.AboutLive do
  use PragmaticWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts("mount")
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    IO.puts("handle params")
    {:noreply, socket}
  end

  # def render(assigns) do
  #   ~L"""
  #   About
  #   """
  # end
end
