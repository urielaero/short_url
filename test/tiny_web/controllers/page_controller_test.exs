defmodule TinyWeb.PageControllerTest do
  use TinyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn) == Routes.url_path(conn, :index)
  end
end
