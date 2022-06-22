defmodule HackerNewsAggregator.Ports.HackerNewsHandler do
  @doc """
  Behaviour for the hacker news API handler
  """

  alias HackerNewsAggregator.Models.Item

  @callback top_stories() :: list(integer()) | {:error, term()}
  def top_stories(), do: adapter().top_stories()

  @callback get_item(integer()) :: Item.t() | {:error, term()}
  def get_item(id), do: adapter().get_item(id)

  defp adapter() do
    :hacker_news_aggregator
    |> Application.get_env(:adapters)
    |> Keyword.get(:hacker_news_handler)
  end
end
