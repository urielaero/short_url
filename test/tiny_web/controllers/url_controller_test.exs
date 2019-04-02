defmodule TinyWeb.UrlControllerTest do
  use TinyWeb.ConnCase

  alias Tiny.TinyUrl

  @create_attrs %{alive: "2010-04-17T14:00:00Z", counter: 42, url: "http://someurl.com"}
  @invalid_attrs %{alive: nil, counter: nil, url: nil}

  def fixture(:url) do
    {:ok, url} = TinyUrl.create_url(@create_attrs)
    url
  end

  describe "index" do
    test "lists all urls", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Urls"
    end
  end

  describe "new url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :new))
      assert html_response(conn, 200) =~ "New Url"
    end
  end

  describe "create url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.url_path(conn, :show, id)

      conn = get(conn, Routes.url_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Url"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Url"
    end
  end
end
