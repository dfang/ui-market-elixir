defmodule Pragmatic.PartnersTest do
  use Pragmatic.DataCase

  alias Pragmatic.Partners

  describe "partners" do
    alias Pragmatic.Partners.Partner

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Partners.create_partner()

      partner
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Partners.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Partners.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Partners.create_partner(@valid_attrs)
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Partners.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Partners.update_partner(partner, @update_attrs)
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Partners.update_partner(partner, @invalid_attrs)
      assert partner == Partners.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Partners.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Partners.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Partners.change_partner(partner)
    end
  end

  describe "image" do
    alias Pragmatic.Partners.Partner

    @valid_attrs %{name: "some name", position: 42, url: "some url"}
    @update_attrs %{name: "some updated name", position: 43, url: "some updated url"}
    @invalid_attrs %{name: nil, position: nil, url: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Partners.create_partner()

      partner
    end

    test "list_image/0 returns all image" do
      partner = partner_fixture()
      assert Partners.list_image() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Partners.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Partners.create_partner(@valid_attrs)
      assert partner.name == "some name"
      assert partner.position == 42
      assert partner.url == "some url"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Partners.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Partners.update_partner(partner, @update_attrs)
      assert partner.name == "some updated name"
      assert partner.position == 43
      assert partner.url == "some updated url"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Partners.update_partner(partner, @invalid_attrs)
      assert partner == Partners.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Partners.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Partners.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Partners.change_partner(partner)
    end
  end

  describe "partners" do
    alias Pragmatic.Partners.Partner

    @valid_attrs %{image: "some image", name: "some name", position: 42, url: "some url"}
    @update_attrs %{
      image: "some updated image",
      name: "some updated name",
      position: 43,
      url: "some updated url"
    }
    @invalid_attrs %{image: nil, name: nil, position: nil, url: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Partners.create_partner()

      partner
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Partners.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Partners.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Partners.create_partner(@valid_attrs)
      assert partner.image == "some image"
      assert partner.name == "some name"
      assert partner.position == 42
      assert partner.url == "some url"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Partners.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Partners.update_partner(partner, @update_attrs)
      assert partner.image == "some updated image"
      assert partner.name == "some updated name"
      assert partner.position == 43
      assert partner.url == "some updated url"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Partners.update_partner(partner, @invalid_attrs)
      assert partner == Partners.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Partners.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Partners.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Partners.change_partner(partner)
    end
  end

  describe "partners" do
    alias Pragmatic.Partners.Partner

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Partners.create_partner()

      partner
    end

    test "paginate_partners/1 returns paginated list of partners" do
      for _ <- 1..20 do
        partner_fixture()
      end

      {:ok, %{partners: partners} = page} = Partners.paginate_partners(%{})

      assert length(partners) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Partners.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Partners.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Partners.create_partner(@valid_attrs)
      assert partner.name == "some name"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Partners.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, partner} = Partners.update_partner(partner, @update_attrs)
      assert %Partner{} = partner
      assert partner.name == "some updated name"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Partners.update_partner(partner, @invalid_attrs)
      assert partner == Partners.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Partners.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Partners.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Partners.change_partner(partner)
    end
  end
end
