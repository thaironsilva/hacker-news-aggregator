defmodule HackerNewsAggregator.Genservers.StoriesUpdater do
  @moduledoc """
  Genservers responsible for updating the top stories
  """
  use GenServer

  alias HackerNewsAggregator.Ports.HackerNewsHandler
  alias HackerNewsAggregatorWeb.Endpoint

  @update_interval 300_000

  @spec start_link(Keyword.t()) :: GenServer.on_start()
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    {:ok, nil}
  end

  def top_stories() do
    GenServer.call(__MODULE__, :top_stories)
  end

  @impl true
  def handle_info(:update, _state) do
    stories = get_top_stories()
    Endpoint.broadcast!("story", "update", %{stories: stories})
    schedule_work()

    {:noreply, stories}
  end

  @impl true
  def handle_call(:top_stories, _from, nil) do
    stories = get_top_stories()

    {:reply, stories, stories}
  end

  @impl true
  def handle_call(:top_stories, _from, state) do
    {:reply, state, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :update, @update_interval)
  end

  defp get_top_stories() do
    case HackerNewsHandler.top_stories() do
      {:error, _reason} -> nil
      top_stories -> Enum.slice(top_stories, 0..49)
    end
  end
end
