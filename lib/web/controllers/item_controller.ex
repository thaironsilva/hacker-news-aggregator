defmodule HackerNewsAggregatorWeb.Controllers.ItemController do
  use HackerNewsAggregatorWeb, :controller

  alias HackerNewsAggregator.Ports.HackerNewsHandler
  alias HackerNewsAggregatorWeb.Views.ItemView

  def show(conn, %{"id" => id}) do
    item = HackerNewsHandler.get_item(id)

    conn
    |> put_status(200)
    |> put_view(ItemView)
    |> render("item.json", item: item)
  end
end
