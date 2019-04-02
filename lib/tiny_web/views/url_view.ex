defmodule TinyWeb.UrlView do
  use TinyWeb, :view

  @config Application.get_env(:tiny, :urls)

  def get_url_alias(a) do
    domain = Keyword.get(@config, :domain, "http://localhost/")
    "#{domain}#{a}"
  end
end
