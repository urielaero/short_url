defmodule Tiny.TinyUrlTest do
  use Tiny.DataCase

  alias Tiny.TinyUrl

  describe "urls" do
    alias Tiny.TinyUrl.Url

    @valid_attrs %{alive: nil, url: "http://someurl.com/"}
    @update_attrs %{alive: "2011-05-18T15:01:01Z", url: "https://someurl.com/"}
    @invalid_attrs %{alias: nil, alive: nil, counter: nil, url: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TinyUrl.create_url()

      url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %Url{} = url} = TinyUrl.create_url(@valid_attrs)
      assert url.alias
      assert url.alias != url.url
      assert url.alive != nil
      assert url.url == "http://someurl.com/"
    end

    test "create_url/1 with valid data and alias conserve alias" do
      valid = Map.put(@valid_attrs, :alias, "some")
      assert {:ok, %Url{} = url} = TinyUrl.create_url(valid)
      assert url.alias == "some"
      assert url.url == "http://someurl.com/"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TinyUrl.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %Url{} = url} = TinyUrl.update_url(url, @update_attrs)
      assert url.alive != nil
      assert url.url == "https://someurl.com/"
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = TinyUrl.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> TinyUrl.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = TinyUrl.change_url(url)
    end
  end
end
