defmodule HackerNewsAggregator.Adapters.HTTPHackerNewsHandler do
  @doc """
  Behaviour for the hacker news API handler
  """

  @behaviour HackerNewsAggregator.Ports.HackerNewsHandler

  alias HackerNewsAggregator.Models.Item
  alias Ecto.Changeset

  @impl true
  def top_stories do
    url = "#{url()}topstories.json"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @impl true
  def get_item(id) do
    url = "#{url()}item/#{id}.json"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: nil}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Item.changeset()
        |> Changeset.apply_changes()

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp url() do
    Application.get_env(:hacker_news_aggregator, :hacker_news_url)
  end
end
