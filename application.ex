defmodule HackerNewsAggregator.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [HackerNewsAggregator.Genservers.StoriesUpdater]

    Supervisor.start_link(children, name: HackerNewsAggregator.Supervisor)
  end
end
