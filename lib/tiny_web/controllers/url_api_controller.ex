defmodule TinyWeb.UrlApiController do
  use TinyWeb, :controller

  alias Tiny.TinyUrl
  alias Tiny.TinyUrl.Url

  action_fallback TinyWeb.FallbackController

  def index(conn, _params) do
    urls = TinyUrl.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %Url{} = url} <- TinyUrl.create_url(url_params) do
      conn
      |> put_status(:created)
      |> render("show.json", url_api: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = TinyUrl.get_url!(id)
    render(conn, "show.json", url_api: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = TinyUrl.get_url!(id)

    with {:ok, %Url{} = url} <- TinyUrl.update_url(url, url_params) do
      render(conn, "show.json", url_api: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = TinyUrl.get_url!(id)

    with {:ok, %Url{}} <- TinyUrl.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end
