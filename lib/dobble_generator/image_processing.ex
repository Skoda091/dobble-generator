defmodule DobbleGenerator.ImageProcessing do
  @moduledoc """
  The ImageProcessing context.
  """
  import Mogrify

  alias DobbleGenerator.ImageProcessing.Picture
  alias DobbleGenerator.Picture, as: PictureUploader
  alias DobbleGenerator.ImageProcessing.Mogrify.Montage
  alias DobbleGenerator.ImageProcessing.Algorithm

  @base_path Path.expand("./priv/static/images/")

  def generate_dobble_images(base_images) do
    with _ <- gc_result_images(),
         processed_base_images <- process_base_images(base_images),
         {:ok, cards} <- Algorithm.execute(processed_base_images),
         timestamp <- :rand.uniform(999_999),
         result_images <- process_montage(cards, timestamp),
         _ <- gc_base_images(base_images) do
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
      |> Enum.map(& &1.path)
      |> Enum.map(&String.split(&1, "/"))
      |> Enum.map(&List.last/1)
      |> Enum.map(&String.to_charlist/1)

    {:ok, path} = :zip.create("#{@base_path}/#{file_name}", files, cwd: @base_path)

    path = path |> String.split("/") |> List.last()
    {:ok, "/images/#{[path]}"}
  end

  defp gc_base_images(images) do
    for image <- images do
      :ok = PictureUploader.delete(image)
    end
  end

  defp gc_result_images() do
    "#{@base_path}/dobble_set_*.png"
    |> Path.wildcard()
    |> Enum.map(&String.split(&1, "/"))
    |> Enum.map(&List.last/1)
    |> Enum.each(&PictureUploader.delete/1)
  end

  defp process_montage(cards, timestamp) do
    for {card_images, index} <- Enum.with_index(cards, 1) do
      result_image = create_result_image("#{@base_path}/#{file_name(timestamp, index)}")
      Montage.process(card_images, result_image, "geometry +2+2")
    end
  end

  defp process_base_images(base_images) do
    for base_image <- base_images do
      ".#{PictureUploader.url(base_image)}"
      |> open()
      |> resize("100x100")
      |> save(in_place: true)
    end
  end

  defp create_result_image(path) do
    %Mogrify.Image{}
    |> custom("size", "500x500")
    |> custom("background", "#000000")
    |> custom("gravity", "center")
    |> canvas("white")
    |> create(path: path)
  end

  defp file_name(timestamp, index) do
    "dobble_set_#{timestamp}_#{index}.png"
  end

  def change_picture(%Picture{} = picture) do
    Picture.changeset(picture, %{})
  end
end
