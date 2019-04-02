defmodule TinyWeb.UrlController do
  use TinyWeb, :controller

  alias Tiny.TinyUrl
  alias Tiny.TinyUrl.Url

  def index(conn, _params) do
    urls = TinyUrl.list_urls()
    render(conn, "index.html", urls: urls)
  end

  def new(conn, _params) do
    changeset = TinyUrl.change_url(%Url{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"url" => url_params}) do
    case TinyUrl.create_url(url_params) do
      {:ok, url} ->
        conn
        |> put_flash(:info, "Url created successfully.")
        |> redirect(to: Routes.url_path(conn, :show, url))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    url = TinyUrl.get_url!(id)
    render(conn, "show.html", url: url)
  end
end
