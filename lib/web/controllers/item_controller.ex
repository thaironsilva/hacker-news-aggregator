defmodule HackerNewsAggregatorWeb.Controllers.ItemController do
  use HackerNewsAggregatorWeb, :controller

  alias HackerNewsAggregator.Ports.HackerNewsHandler
  alias HackerNewsAggregatorWeb.ControllerHelpers
  alias HackerNewsAggregatorWeb.Views.ItemView
  alias HackerNewsAggregatorWeb.ErrorView

  require Logger

  @per_page 10

  def show(conn, %{"id" => id}) do
    case HackerNewsHandler.get_item(id) do
      {:error, :not_found} ->
        Logger.info("Message with #{id} not found")

        conn
        |> put_status(404)
        |> put_view(ErrorView)
        |> render("404.json")

      {:error, reason} ->
        Logger.error("Unexpected connection error with client", error: reason)

        conn
        |> put_status(408)
        |> put_view(ErrorView)
        |> render("408.json")

      item ->
        conn
        |> put_status(200)
        |> put_view(ItemView)
        |> render("item.json", item: item)
    end
  end

  def list_story(conn, params) do
    with {:ok, page} <- ControllerHelpers.integer_parser(params["page"]),
         {:ok, page} <- ControllerHelpers.validate_page(page) do
      case HackerNewsHandler.top_stories() do
        {:error, reason} ->
          Logger.error("Unexpected connection error with client", error: reason)

          conn
          |> put_status(408)
          |> put_view(ErrorView)
          |> render("408.json")

        ids ->
          to = @per_page * page
          from = to - @per_page + 1

          items =
            ids
            |> Enum.slice(from..to)
            |> Enum.map(&HackerNewsHandler.get_item(&1))

          conn
          |> ControllerHelpers.put_content_range(page)
          |> put_status(200)
          |> put_view(ItemView)
          |> render("items.json", items: items)
      end
    else
      {:error, _reason} ->
        Logger.error("Invalid params.")

        conn
        |> put_status(400)
        |> put_view(ErrorView)
        |> render("400.json")
    end
  end
end
