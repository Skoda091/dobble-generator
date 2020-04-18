defmodule DobbleGenerator.ImageProcessing do
  @moduledoc """
  The ImageProcessing context.
  """
  import Mogrify

  require Logger

  alias DobbleGenerator.ImageProcessing.Picture
  alias DobbleGenerator.Picture, as: PictureUploader
  alias DobbleGenerator.ImageProcessing.Mogrify.Montage
  alias DobbleGenerator.ImageProcessing.Algorithm
  alias DobbleGenerator.ImageProcessing.LogImages

  @base_path Path.expand("./priv/static/images/")
  @bucket "dobble-generator"

  def generate_dobble_images(base_images) do
    with processed_base_images <- process_base_images(base_images),
         {:ok, cards} <- Algorithm.execute(processed_base_images),
         timestamp <- :rand.uniform(999_999),
         result_images <- process_montage(cards, timestamp) do
      # LogImages.log("IMAGE_PROCESSING_1")

      {:ok, result_images}
    else
      {:error, msq} -> {:error, msq}
    end
  end

  def generate_zip(images) do
    timestamp = :os.system_time(:second)
    file_name = "dobble_set_zipped_#{timestamp}.zip"

    files =
      images
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(&get_file_path(&1))
      |> Enum.map(&String.to_charlist/1)

    file_name = get_file_path(file_name)

    Logger.debug("X:FILE_NAME")
    Logger.debug(Kernel.inspect(file_name))

    Logger.debug("X:FILES")
    Logger.debug(Kernel.inspect(files))

    Logger.debug("X:PATH")
    Logger.debug(Kernel.inspect(get_path()))



    {:ok, path} = :zip.create(file_name, files, cwd: get_path())

    path = path |> String.split("/") |> List.last() |> get_file_path()

    PictureUploader.store(path)
    {:ok, path}
  end

  defp gc_base_images(images) do
    for image <- images do
      :ok = PictureUploader.delete(image)
    end
  end

  # defp gc_result_images() do
  #   "#{@base_path}/dobble_set_*.png"
  #   |> Path.wildcard()
  #   |> Enum.map(&String.split(&1, "/"))
  #   |> Enum.map(&List.last/1)
  #   |> Enum.each(&PictureUploader.delete/1)
  # end

  def gc_s3_images() do
    stream =
      ExAws.S3.list_objects(@bucket, prefix: "uploads/")
      |> ExAws.stream!()
      |> Stream.map(& &1.key)

    {:ok, _} = ExAws.S3.delete_all_objects(@bucket, stream) |> ExAws.request()
  end

  defp process_montage(cards, timestamp) do
    for {card_images, index} <- Enum.with_index(cards, 1) do
      %Mogrify.Image{path: path} =
        %{path: result_image_path} =
        result_image = create_result_image("#{@base_path}/#{file_name(timestamp, index)}")

      Logger.debug(path)
      Montage.process(card_images, result_image, "geometry +2+2")
      PictureUploader.store(result_image_path)
    end
  end

  defp process_base_images(base_images) do
    for base_image <- base_images do
      local_path = get_file_path(base_image)

      @bucket
      |> ExAws.S3.download_file("uploads/#{base_image}", local_path)
      |> ExAws.request!()

      local_path
      |> open()
      |> resize("100x100")
      |> save(in_place: true)
    end
  end

  defp create_result_image(path) do
    %{path: result_image_path} =
      result_image =
      %Mogrify.Image{}
      |> custom("size", "500x500")
      |> custom("background", "#000000")
      |> custom("gravity", "center")
      |> canvas("white")
      |> create(path: path)

    {:ok, _filename} = PictureUploader.store(result_image_path)
    result_image
  end

  defp file_name(timestamp, index) do
    "dobble_set_#{timestamp}_#{index}.png"
  end

  def change_picture(%Picture{} = picture) do
    Picture.changeset(picture, %{})
  end

  defp get_file_path(filename) do
    case Mix.env do
      :dev -> "#{@base_path}/#{filename}"
      :prod ->
        File.touch!("/tmp/a.txt")
        "/tmp/#{filename}"
    end
  end

  defp get_path() do
    case Mix.env do
      :dev -> @base_path
      :prod ->
        File.touch!("/tmp/a.txt")
        "/tmp/"
    end
  end
end
