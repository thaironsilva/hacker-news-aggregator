defmodule HackerNewsAggregator.MixProject do
  use Mix.Project

  def project do
    [
      app: :hacker_news_aggregator,
      version: "0.1.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {HackerNewsAggregator.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto, "~> 3.8.4"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:mock, "~> 0.3.7", only: :test}
    ]
  end
end
