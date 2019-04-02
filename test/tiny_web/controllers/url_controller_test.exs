defmodule TinyWeb.UrlControllerTest do
  use TinyWeb.ConnCase

  alias Tiny.TinyUrl

  @create_attrs %{alive: "2010-04-17T14:00:00Z", counter: 42, url: "http://someurl.com"}
  @update_attrs %{alive: "2011-05-18T15:01:01Z", counter: 43, url: "https://someurl.com"}
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

  describe "edit url" do
    setup [:create_url]

    test "renders form for editing chosen url", %{conn: conn, url: url} do
      conn = get(conn, Routes.url_path(conn, :edit, url))
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "update url" do
    setup [:create_url]

    test "redirects when data is valid", %{conn: conn, url: url} do
      conn = put(conn, Routes.url_path(conn, :update, url), url: @update_attrs)
      assert redirected_to(conn) == Routes.url_path(conn, :show, url)

      conn = get(conn, Routes.url_path(conn, :show, url))
      assert html_response(conn, 200) =~ "someurl.com"
    end

    test "renders errors when data is invalid", %{conn: conn, url: url} do
      conn = put(conn, Routes.url_path(conn, :update, url), url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "delete url" do
    setup [:create_url]

    test "deletes chosen url", %{conn: conn, url: url} do
      conn = delete(conn, Routes.url_path(conn, :delete, url))
      assert redirected_to(conn) == Routes.url_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.url_path(conn, :show, url))
      end
    end
  end

  defp create_url(_) do
    url = fixture(:url)
    {:ok, url: url}
  end
end
