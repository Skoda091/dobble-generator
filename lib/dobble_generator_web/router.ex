defmodule DobbleGeneratorWeb.Router do
  use DobbleGeneratorWeb, :router

  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DobbleGeneratorWeb do
    pipe_through :browser

    get "/", PictureController, :show
    # resources "/pictures", PictureController

    resources "/pictures", PictureController, only: [:show, :new, :create], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", DobbleGeneratorWeb do
  #   pipe_through :api
  # end
end
