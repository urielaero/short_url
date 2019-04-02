defmodule TinyWeb.UrlApiView do
  use TinyWeb, :view
  alias TinyWeb.UrlApiView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, UrlApiView, "url_api.json")}
  end

  def render("show.json", %{url_api: url_api}) do
    %{data: render_one(url_api, UrlApiView, "url_api.json")}
  end

  def render("url_api.json", %{url_api: url_api}) do
    %{id: url_api.id,
      url: url_api.url,
      alias: url_api.alias,
      counter: url_api.counter,
      alive: url_api.alive}
  end
end
