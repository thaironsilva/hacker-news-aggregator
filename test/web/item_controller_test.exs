defmodule HackerNewsAggregatorWeb.ItemControllerTest do
  @moduledoc false
  use ExUnit.Case, async: true

  import Mock
  import Plug.Conn
  import Phoenix.ConnTest

  alias HackerNewsAggregatorWeb.Router.Helpers, as: Routes

  @endpoint HackerNewsAggregatorWeb.Endpoint

  setup do
    {:ok, %{conn: build_conn()}}
  end

  @id 1
  @item %{
    by: "pg",
    descendants: 15,
    id: 1,
    kids: [15, 234_509, 487_171, 82729],
    score: 57,
    time: 1_160_418_111,
    title: "Y Combinator",
    type: "story",
    url: "http://ycombinator.com"
  }

  @get_item_response200 {:ok,
                         %HTTPoison.Response{
                           body: Jason.encode!(@item),
                           headers: [
                             {"Server", "nginx"},
                             {"Date", "Sat, 18 Jun 2022 23:51:52 GMT"},
                             {"Content-Type", "application/json; charset=utf-8"},
                             {"Content-Length", "165"},
                             {"Connection", "keep-alive"},
                             {"Access-Control-Allow-Origin", "*"},
                             {"Cache-Control", "no-cache"},
                             {"Strict-Transport-Security",
                              "max-age=31556926; includeSubDomains; preload"}
                           ],
                           request: %HTTPoison.Request{
                             body: "",
                             headers: [],
                             method: :get,
                             options: [],
                             params: %{},
                             url: "https://hacker-news.firebaseio.com/v0/item/1.json"
                           },
                           request_url: "https://hacker-news.firebaseio.com/v0/item/1.json",
                           status_code: 200
                         }}

  test "GET /api/v0/item/:id", %{conn: conn} do
    with_mock HTTPoison,
      get: fn "https://hacker-news.firebaseio.com/v0/item/1.json" ->
        @get_item_response200
      end do
      assert render(@item) ==
               conn
               |> get("/api/v0/item/#{@id}")
               |> json_response(200)
    end
  end

  defp render(item) do
    %{
      "id" => item.id,
      "by" => item.by,
      "descendants" => item.descendants,
      "kids" => item.kids,
      "score" => item.score,
      "time" => item.time,
      "title" => item.title,
      "type" => item.type,
      "url" => item.url
    }
  end
end
