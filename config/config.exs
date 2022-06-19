import Config

config :hacker_news_aggregator,
  adapters: [
    http: HackerNewsAggregator.Adapters.HTTPHackerNewsHandler
  ],
  hacker_news_url: "https://hacker-news.firebaseio.com/v0/"

config :phoenix, :json_library, Jason

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HackerNewsAggregatorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: HackerNewsAggregator.PubSub
