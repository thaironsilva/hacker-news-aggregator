defmodule HackerNewsAggregator.Ports.HackerNewsHandler do
  @doc """
  Behaviour for the hacker news API handler
  """

  alias HackerNewsAggregator.Models.Item

  @callback top_stories() :: list(integer()) | term()
  def top_stories(adapter \\ :http), do: adapter(adapter).top_stories()

  @callback get_story(integer()) :: Item.t() | term()
  def get_story(id, adapter \\ :http), do: adapter(adapter).get_story(id)

  defp adapter(adapter) do
    :hacker_news_aggregator
    |> Application.get_env(:adapters)
    |> get_in([:hacker_news_handler, adapter])
  end
end
