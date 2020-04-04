defmodule DobbleGenerator.ImageProcessingTest do
  use DobbleGenerator.DataCase

  alias DobbleGenerator.ImageProcessing

  describe "pictures" do
    alias DobbleGenerator.ImageProcessing.Picture

    @valid_attrs %{image: "some image", title: "some title"}
    @update_attrs %{image: "some updated image", title: "some updated title"}
    @invalid_attrs %{image: nil, title: nil}

    def picture_fixture(attrs \\ %{}) do
      {:ok, picture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ImageProcessing.create_picture()

      picture
    end

    test "list_pictures/0 returns all pictures" do
      picture = picture_fixture()
      assert ImageProcessing.list_pictures() == [picture]
    end

    test "get_picture!/1 returns the picture with given id" do
      picture = picture_fixture()
      assert ImageProcessing.get_picture!(picture.id) == picture
    end

    test "create_picture/1 with valid data creates a picture" do
      assert {:ok, %Picture{} = picture} = ImageProcessing.create_picture(@valid_attrs)
      assert picture.image == "some image"
      assert picture.title == "some title"
    end

    test "create_picture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ImageProcessing.create_picture(@invalid_attrs)
    end

    test "update_picture/2 with valid data updates the picture" do
      picture = picture_fixture()
      assert {:ok, %Picture{} = picture} = ImageProcessing.update_picture(picture, @update_attrs)
      assert picture.image == "some updated image"
      assert picture.title == "some updated title"
    end

    test "update_picture/2 with invalid data returns error changeset" do
      picture = picture_fixture()
      assert {:error, %Ecto.Changeset{}} = ImageProcessing.update_picture(picture, @invalid_attrs)
      assert picture == ImageProcessing.get_picture!(picture.id)
    end

    test "delete_picture/1 deletes the picture" do
      picture = picture_fixture()
      assert {:ok, %Picture{}} = ImageProcessing.delete_picture(picture)
      assert_raise Ecto.NoResultsError, fn -> ImageProcessing.get_picture!(picture.id) end
    end

    test "change_picture/1 returns a picture changeset" do
      picture = picture_fixture()
      assert %Ecto.Changeset{} = ImageProcessing.change_picture(picture)
    end
  end
end
