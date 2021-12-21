defmodule PragmaticWeb.HomeLiveTest do
  use PragmaticWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "latest"
    assert render(page_live) =~ "latest"
  end
end
