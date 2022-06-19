defmodule HackerNewsAggregator.Ports.HackerNewsHandler do
  @doc """
  Behaviour for the hacker news API handler
  """

  alias HackerNewsAggregator.Models.Item

  @callback top_stories() :: list(integer()) | {:error, term()}
  def top_stories(adapter \\ :http), do: adapter(adapter).top_stories()

  @callback get_item(integer()) :: Item.t() | {:error, term()}
  def get_item(id, adapter \\ :http), do: adapter(adapter).get_item(id)

  defp adapter(adapter) do
    :hacker_news_aggregator
    |> Application.get_env(:adapters)
    |> Keyword.get(adapter)
  end
end
