defmodule Pragmatic.BannersTest do
  use Pragmatic.DataCase

  alias Pragmatic.Banners

  describe "banners" do
    alias Pragmatic.Banners.Banner

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def banner_fixture(attrs \\ %{}) do
      {:ok, banner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banners.create_banner()

      banner
    end

    test "list_banners/0 returns all banners" do
      banner = banner_fixture()
      assert Banners.list_banners() == [banner]
    end

    test "get_banner!/1 returns the banner with given id" do
      banner = banner_fixture()
      assert Banners.get_banner!(banner.id) == banner
    end

    test "create_banner/1 with valid data creates a banner" do
      assert {:ok, %Banner{} = banner} = Banners.create_banner(@valid_attrs)
    end

    test "create_banner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banners.create_banner(@invalid_attrs)
    end

    test "update_banner/2 with valid data updates the banner" do
      banner = banner_fixture()
      assert {:ok, %Banner{} = banner} = Banners.update_banner(banner, @update_attrs)
    end

    test "update_banner/2 with invalid data returns error changeset" do
      banner = banner_fixture()
      assert {:error, %Ecto.Changeset{}} = Banners.update_banner(banner, @invalid_attrs)
      assert banner == Banners.get_banner!(banner.id)
    end

    test "delete_banner/1 deletes the banner" do
      banner = banner_fixture()
      assert {:ok, %Banner{}} = Banners.delete_banner(banner)
      assert_raise Ecto.NoResultsError, fn -> Banners.get_banner!(banner.id) end
    end

    test "change_banner/1 returns a banner changeset" do
      banner = banner_fixture()
      assert %Ecto.Changeset{} = Banners.change_banner(banner)
    end
  end
end
