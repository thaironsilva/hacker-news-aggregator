defmodule HackerNewsAggregator.Adapters.HTTPHackerNewsHandler do
  @doc """
  Behaviour for the hacker news API handler
  """

  @behaviour HackerNewsAggregator.Ports.HackerNewsHandler

  alias HackerNewsAggregator.Models.Item

  def top_stories do
    handle_call("#{url()}topstories.json")
  end

  def get_story(id) do
    handle_call("#{url()}item/#{id}.json")
  end

  defp url() do
    Application.get_env(:hacker_news_aggregator, :hacker_news_url)
  end

  defp handle_call(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        :not_found

      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end
end
