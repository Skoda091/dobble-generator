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
    LogImages.log("PICTURE_CONTROLLER_CREATE_1")

    file_names =
      for %{filename: filename} = plug_upload_img <- plug_upload_imgs do
        timestamp = :os.system_time(:second)
        [name, ext] = filename |> String.replace(" ", "_") |> String.split(".")
        file_name = "#{name}_#{timestamp}.#{ext}"
        plug_upload_img = %{plug_upload_img | filename: file_name}
        {:ok, file_name} = PictureUploader.store(plug_upload_img)
        Logger.debug(file_name)
        file_name
      end

    LogImages.log("PICTURE_CONTROLLER_CREATE_2")

    case ImageProcessing.generate_dobble_images(file_names) do
      {:ok, dobble_images} ->
        encoded_dobble_images =
          dobble_images
          |> Enum.map(& &1.path)
          |> Enum.map(fn path -> path |> String.split("/") |> List.last() end)
          |> Jason.encode!()

        {:ok, zip_file} = ImageProcessing.generate_zip(dobble_images)

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
    LogImages.log("PICTURE_CONTROLLER_SHOW_1")

    pictures =
      file_names
      |> Jason.decode!()
      |> Enum.map(fn file_name -> %Picture{id: "", image: "/images/#{file_name}"} end)

    IO.inspect(zip_file, label: "LABEL")

    render(conn, "show.html", pictures: pictures, zip_file: Jason.decode!(zip_file))
  end

  def show(conn, %{}) do
    render(conn, "show.html", pictures: [], zip_file: nil)
  end
end
