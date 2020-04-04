defmodule DobbleGenerator.ImageProcessing.Mogrify.Montage do
  def process(images, result_image, opts \\ []) do
    montage(images, result_image, opts)
  end

  defp montage(images, result_image, _opts) do
    cmd_opts = [stderr_to_stdout: true]

    (images ++ [result_image])
    |> Enum.map(& &1.path)
    |> cmd_montage(cmd_opts)

    image_after_command(result_image)
  end

  defp cmd_montage(images_path, opts) do
    System.cmd("montage", images_path, opts)
  end

  defp image_after_command(%{path: path, format: format, dirty: dirty} = image) do
    format = Map.get(dirty, :format, format)

    %{
      clear_operations(image)
      | path: path,
        ext: Path.extname(path),
        format: format
    }
  end

  defp clear_operations(image) do
    %{image | operations: [], dirty: %{}}
  end
end
