defmodule HackerNewsAggregatorWeb.Router do
  @moduledoc """
  Router for the API
  """
  use HackerNewsAggregatorWeb, :router

  alias HackerNewsAggregatorWeb.Controllers.ItemController

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api/v0" do
    pipe_through(:api)

    get("/items/:id", ItemController, :show)
    get("/stories", ItemController, :list_stories)
  end
end
