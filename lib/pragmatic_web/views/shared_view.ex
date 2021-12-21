defmodule PragmaticWeb.SharedView do
  use PragmaticWeb, :view

  # def mount(_params, _session, socket) do
  #   IO.puts("mount in shared view")
  #   socket = assign(socket)
  #   {:ok, socket}
  # end

  @impl true
  def handle_params(_params, _url, socket) do
    IO.puts("handle params in shared view")
    {:noreply, socket}
  end
end
