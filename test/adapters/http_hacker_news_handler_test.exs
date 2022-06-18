defmodule HackerNewsAggregator.Adapters.HackerNewsHandlerTest do
  use ExUnit.Case, async: true

  import Mock

  alias HackerNewsAggregator.Adapters.HTTPHackerNewsHandler

  @top_stories Enum.map(1..50, & &1)
  @response200 {:ok,
                %HTTPoison.Response{
                  body: Jason.encode!(@top_stories),
                  headers: [
                    {"Server", "nginx"},
                    {"Date", "Sat, 18 Jun 2022 20:48:50 GMT"},
                    {"Content-Type", "application/json; charset=utf-8"},
                    {"Content-Length", "4501"},
                    {"Connection", "keep-alive"},
                    {"Access-Control-Allow-Origin", "*"},
                    {"Cache-Control", "no-cache"},
                    {"Strict-Transport-Security", "max-age=31556926; includeSubDomains; preload"}
                  ],
                  request: %HTTPoison.Request{
                    body: "",
                    headers: [],
                    method: :get,
                    options: [],
                    params: %{},
                    url: "https://hacker-news.firebaseio.com/v0/topstories.json"
                  },
                  request_url: "https://hacker-news.firebaseio.com/v0/topstories.json",
                  status_code: 200
                }}

  test "should return top 50 stories correctly" do
    with_mock HTTPoison,
      get: fn "https://hacker-news.firebaseio.com/v0/topstories.json" ->
        @response200
      end do
      assert @top_stories == HTTPHackerNewsHandler.top_stories()
    end
  end
end
