defmodule HackerNewsAggregatorWeb.Channels.StoryChannel do
  use Phoenix.Channel

  alias HackerNewsAggregator.Genservers.StoriesUpdater

  def join("story", _message, socket) do
    {:ok, socket}
  end

  def handle_in("top_stories", _payload, socket) do
    stories = StoriesUpdater.top_stories()
    {:reply, {:ok, stories}, socket}
  end

  def handle_in("update", stories, socket) do
    broadcast!(socket, "update", stories)
    {:noreply, socket}
  end
end
