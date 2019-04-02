defmodule TinyWeb.UrlApiControllerTest do
  use TinyWeb.ConnCase

  alias Tiny.TinyUrl

  @create_attrs %{
    url: "https://twitter.com"
  }

  @invalid_attrs %{alias: nil, alive: nil, counter: nil, url: nil}

  def fixture(:url) do
    {:ok, url} = TinyUrl.create_url(@create_attrs)
    url
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all urls", %{conn: conn} do
      conn = get(conn, Routes.url_api_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create url" do
    test "renders url when data is valid", %{conn: conn} do
      conn = post(conn, Routes.url_api_path(conn, :create), url: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.url_api_path(conn, :show, id))

      res = json_response(conn, 200)["data"]
      assert res["url"] == "https://twitter.com"
      assert res["alias"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.url_api_path(conn, :create), url: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
