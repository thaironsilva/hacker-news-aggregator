import Config

config :hacker_news_aggregator,
  adapters: [
    hacker_news_handler: HackerNewsAggregator.Adapters.HackerNewsHandler
  ],
  hacker_news_url: "https://hacker-news.firebaseio.com/v0/"

config :phoenix, :json_library, Jason

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  url: [host: "localhost"],
  render_errors: [view: HackerNewsAggregatorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: HackerNewsAggregator.PubSub
