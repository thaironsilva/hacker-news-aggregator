defmodule HackerNewsAggregator.Genservers.StoriesUpdater do
  @moduledoc """
  Genservers responsible for updating the top stories
  """
  use GenServer

  @spec start_link(Keyword.t()) :: GenServer.on_start()
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    schedule_work()
    {:ok, nil}
  end

  @impl true
  def handle_info(:update, _state) do
    state = HackerNewsAggregator.Ports.HackerNewsHandler.top_stories()

    schedule_work()

    {:noreply, state}
  end

  @impl true
  def handle_call(:top_stories, _from, nil) do
    state = HackerNewsAggregator.Ports.HackerNewsHandler.top_stories()

    {:reply, state, state}
  end

  @impl true
  def handle_call(:top_stories, _from, state) do
    {:reply, state, state}
  end

  defp schedule_work do
    Process.send_after(self(), :update, 300_000)
  end
end
