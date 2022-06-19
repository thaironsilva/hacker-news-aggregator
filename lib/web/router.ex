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

    get("/item/:id", ItemController, :show)
    get("/story", ItemController, :list_story)
  end
end
