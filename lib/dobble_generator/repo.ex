defmodule DobbleGenerator.Repo do
  use Ecto.Repo,
    otp_app: :dobble_generator,
    adapter: Ecto.Adapters.Postgres
end
