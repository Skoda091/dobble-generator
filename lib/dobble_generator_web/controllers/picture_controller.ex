defmodule DobbleGeneratorWeb.PictureController do
  use DobbleGeneratorWeb, :controller

  require Logger

  alias DobbleGenerator.ImageProcessing
  alias DobbleGenerator.ImageProcessing.Picture
  alias DobbleGenerator.Picture, as: PictureUploader
  alias DobbleGenerator.ImageProcessing.LogImages

  def new(conn, _params) do
    changeset = ImageProcessing.change_picture(%Picture{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"picture" => %{"images" => plug_upload_imgs}}) do
    # LogImages.log("PICTURE_CONTROLLER_CREATE_1")

    {:ok, _} = ImageProcessing.gc_s3_images()

    timestamp = :os.system_time(:second)

    file_names =
      for %{filename: filename} = plug_upload_img <- plug_upload_imgs do
        [name, ext] = filename |> String.replace(" ", "_") |> String.split(".")
        file_name = "#{name}_#{timestamp}.#{ext}"
        plug_upload_img = %{plug_upload_img | filename: file_name}
        {:ok, file_name} = PictureUploader.store(plug_upload_img)
        Logger.debug(file_name)
        file_name
      end

    # LogImages.log("PICTURE_CONTROLLER_CREATE_2")

    case ImageProcessing.generate_dobble_images(file_names) do
      {:ok, dobble_images} ->
        encoded_dobble_images =
          dobble_images
          |> Enum.map(&elem(&1, 1))
          # |> Enum.map(fn path -> path |> String.split("/") |> List.last() end)
          |> Jason.encode!()

        {:ok, zip_file} = ImageProcessing.generate_zip(dobble_images)
        # zip_file = ""

        conn
        |> put_flash(:info, "Cards generated successfully.")
        |> redirect(
          to:
            Routes.picture_path(conn, :show,
              file_names: encoded_dobble_images,
              zip_file: Jason.encode!(zip_file)
            )
        )

      {:error, _msg} ->
        conn
        |> put_flash(
          :error,
          "Incorrect number of symbols images uploaded! Currently supported number of is 13 or 57."
        )
        |> redirect(to: Routes.picture_path(conn, :show))
    end
  end

  def show(conn, %{"file_names" => file_names, "zip_file" => zip_file}) do
    pictures =
      file_names
      |> Jason.decode!()
      |> Enum.map(&PictureUploader.url/1)
      |> Enum.map(fn file_url -> %Picture{id: "", image: file_url} end)

    zip_file =
      zip_file
      |> Jason.decode!()
      |> PictureUploader.url()
    render(conn, "show.html", pictures: pictures, zip_file: zip_file)
  end

  def show(conn, %{}) do
    render(conn, "show.html", pictures: [], zip_file: nil)
  end
end
