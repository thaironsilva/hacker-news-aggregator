defmodule HackerNewsAggregator.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: HackerNewsAggregator.PubSub},
      HackerNewsAggregatorWeb.Endpoint,
      HackerNewsAggregator.Genservers.StoriesUpdater
    ]

    opts = [strategy: :one_for_one, name: HackerNewsAggregator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
