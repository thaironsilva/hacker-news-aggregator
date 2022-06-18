defmodule HackerNewsAggregator.Adapters.HackerNewsHandlerTest do
  use ExUnit.Case, async: true

  import Mock

  alias HackerNewsAggregator.Adapters.HTTPHackerNewsHandler
  alias HackerNewsAggregator.Models.Item

  @top_stories Enum.map(1..50, & &1)
  @top_stories_response200 {:ok,
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
                                {"Strict-Transport-Security",
                                 "max-age=31556926; includeSubDomains; preload"}
                              ],
                              request: %HTTPoison.Request{
                                body: "",
                                headers: [],
                                method: :get,
                                options: [],
                                params: %{},
                                url: "https://hacker-news.firebaseio.com/v0/topstories.json"
                              },
                              request_url:
                                "https://hacker-news.firebaseio.com/v0/topstories.json",
                              status_code: 200
                            }}
  @story %{
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

  @get_story_response200 {:ok,
                          %HTTPoison.Response{
                            body: Jason.encode!(@story),
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

  test "should return top 50 stories correctly" do
    with_mock HTTPoison,
      get: fn "https://hacker-news.firebaseio.com/v0/topstories.json" ->
        @top_stories_response200
      end do
      assert @top_stories == HTTPHackerNewsHandler.top_stories()
    end
  end

  test "should return top one story correctly" do
    with_mock HTTPoison,
      get: fn "https://hacker-news.firebaseio.com/v0/item/1.json" ->
        @get_story_response200
      end do
      assert %{
               by: "pg",
               descendants: 15,
               id: 1,
               kids: [15, 234_509, 487_171, 82729],
               score: 57,
               time: 1_160_418_111,
               title: "Y Combinator",
               type: "story",
               url: "http://ycombinator.com"
             } = HTTPHackerNewsHandler.get_story(1)
    end
  end
end
