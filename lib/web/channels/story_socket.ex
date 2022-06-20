defmodule HackerNewsAggregatorWeb.StorySocket do
  use Phoenix.Socket

  ## Channels
  channel("story", HackerNewsAggregatorWeb.Channels.StoryChannel)
end
