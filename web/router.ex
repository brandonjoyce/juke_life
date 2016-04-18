defmodule JukeLife.Router do
  use JukeLife.Web, :router

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

  scope "/", JukeLife do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/jukes", JukeController
    resources "/selections", SelectionController
  end

  # Other scopes may use custom stacks.
  # scope "/api", JukeLife do
  #   pipe_through :api
  # end
end
