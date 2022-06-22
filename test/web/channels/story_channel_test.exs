defmodule HackerNewsAggregatorWeb.Channels.StoryChannelTest do
  use ExUnit.Case, async: true

  import Mock
  import Phoenix.ChannelTest

  alias HackerNewsAggregator.Genservers.StoriesUpdater
  alias HackerNewsAggregatorWeb.Channels.StoryChannel
  alias HackerNewsAggregatorWeb.StorySocket

  @endpoint HackerNewsAggregatorWeb.Endpoint

  @top_stories Enum.map(1..50, & &1)

  setup do
    {:ok, _, socket} =
      StorySocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(StoryChannel, "stories")

    %{socket: socket}
  end

  test "top_stories replies with top 50 stories", %{socket: socket} do
    with_mock StoriesUpdater,
      top_stories: fn ->
        @top_stories
      end do
      ref = push(socket, "top_stories", nil)

      assert_reply(ref, :ok, @top_stories, 5_000)
    end
  end

  test "receive top 50 stories from update broadcast", %{socket: socket} do
    push(socket, "update", @top_stories)
    assert_broadcast("update", @top_stories)
  end
end
