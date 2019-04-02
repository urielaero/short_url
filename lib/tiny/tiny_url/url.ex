defmodule Tiny.TinyUrl.Url do
  use Ecto.Schema
  import Ecto.Changeset

  @config Application.get_env(:tiny, :urls)

  schema "urls" do
    field :alias, :string
    field :alive, :utc_datetime_usec
    field :counter, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url, :alias, :alive])
    |> validate_required([:url])
    |> unique_constraint(:alias)
    |> validate_format(:url, ~r/(^http:\/\/|^https:\/\/)/)
    |> maybe_put_alias()
    |> alive_time()
  end


  defp maybe_put_alias(changeset) do
    url_alias = get_field(changeset, :alias)
    url = get_field(changeset, :url)
    if url_alias == nil and url != nil do
      new_alias =  rand_str()
      put_change(changeset, :alias, new_alias)
    else
      changeset
    end
  end

  defp alive_time(changeset) do
    user_alive = get_field(changeset, :alive)
    if user_alive == nil do
      now = Date.utc_today()
      days = Keyword.get(@config, :max_alive_days, 10)
      next_days = Date.add(now, days)
      next = Date.to_string(next_days)
      {:ok, datetime, 0} = DateTime.from_iso8601("#{next}T23:59:59.555315Z")
      put_change(changeset, :alive, datetime)
    else
      changeset
    end
  end

  defp rand_str() do
    :crypto.strong_rand_bytes(5)
    |> Base.url_encode64()
    |> binary_part(0, 5)
  end

end
