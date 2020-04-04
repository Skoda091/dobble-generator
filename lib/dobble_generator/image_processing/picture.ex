defmodule DobbleGenerator.ImageProcessing.Picture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pictures" do
    field :image, :string
    timestamps()
  end

  @doc false
  def changeset(picture, attrs) do
    picture
    |> cast(attrs, [:image])
    |> validate_required([:image])
  end
end
