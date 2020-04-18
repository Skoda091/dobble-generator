defmodule DobbleGenerator.ImageProcessing.LogImages do
  require Logger

  def log(stage) do
    Logger.info(stage)
    "priv/static/images" |> File.ls!() |> IO.inspect(limit: :infinity) |> Logger.info()
  end

  def log(tmp, stage) do
    Logger.info(stage)
    tmp |> File.ls!() |> IO.inspect(limit: :infinity) |> Logger.info()
  end
end
