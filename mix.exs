defmodule HackerNewsAggregator.MixProject do
  use Mix.Project

  def project do
    [
      app: :hacker_news_aggregator,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.8.4"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"}
    ]
  end
end
