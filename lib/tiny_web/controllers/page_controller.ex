defmodule TinyWeb.PageController do
  use TinyWeb, :controller

  alias Tiny.TinyUrl

  def index(conn, %{"u" => u}) do
    url = TinyUrl.get_url_alias(u)
    now = DateTime.utc_now()
    available = DateTime.compare(url.alive, now)
    if url != nil and available == :gt do
      TinyUrl.inc_views(url)
      redirect(conn, external: url.url)
    else
      redirect(conn, to: "/404")
    end
  end

  def index(conn, _) do
    redirect(conn, to: "/urls")
  end
end
