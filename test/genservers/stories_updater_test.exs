defmodule HackerNewsAggregator.Genservers.StoriesUpdaterTest do
  use ExUnit.Case, async: true

  import Mock

  alias HackerNewsAggregator.Genservers.StoriesUpdater
  alias HackerNewsAggregator.Ports.HackerNewsHandler

  @top_stories Enum.map(1..50, & &1)

  test "Should return top stories" do
    with_mock HackerNewsHandler, top_stories: fn -> @top_stories end do
      assert @top_stories == StoriesUpdater.top_stories()
    end
  end
end
