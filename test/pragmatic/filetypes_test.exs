defmodule Pragmatic.FiletypesTest do
  use Pragmatic.DataCase

  alias Pragmatic.Filetypes

  describe "filetypes" do
    alias Pragmatic.Filetypes.Filetype

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def filetype_fixture(attrs \\ %{}) do
      {:ok, filetype} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Filetypes.create_filetype()

      filetype
    end

    test "list_filetypes/0 returns all filetypes" do
      filetype = filetype_fixture()
      assert Filetypes.list_filetypes() == [filetype]
    end

    test "get_filetype!/1 returns the filetype with given id" do
      filetype = filetype_fixture()
      assert Filetypes.get_filetype!(filetype.id) == filetype
    end

    test "create_filetype/1 with valid data creates a filetype" do
      assert {:ok, %Filetype{} = filetype} = Filetypes.create_filetype(@valid_attrs)
    end

    test "create_filetype/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Filetypes.create_filetype(@invalid_attrs)
    end

    test "update_filetype/2 with valid data updates the filetype" do
      filetype = filetype_fixture()
      assert {:ok, %Filetype{} = filetype} = Filetypes.update_filetype(filetype, @update_attrs)
    end

    test "update_filetype/2 with invalid data returns error changeset" do
      filetype = filetype_fixture()
      assert {:error, %Ecto.Changeset{}} = Filetypes.update_filetype(filetype, @invalid_attrs)
      assert filetype == Filetypes.get_filetype!(filetype.id)
    end

    test "delete_filetype/1 deletes the filetype" do
      filetype = filetype_fixture()
      assert {:ok, %Filetype{}} = Filetypes.delete_filetype(filetype)
      assert_raise Ecto.NoResultsError, fn -> Filetypes.get_filetype!(filetype.id) end
    end

    test "change_filetype/1 returns a filetype changeset" do
      filetype = filetype_fixture()
      assert %Ecto.Changeset{} = Filetypes.change_filetype(filetype)
    end
  end
end
