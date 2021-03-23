defmodule PragmaticWeb.PageControllerTest do
  use PragmaticWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "latest"
  end
end
