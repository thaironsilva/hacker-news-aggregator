import Config

config :hacker_news_aggregator,
  adapters: [
    http: HackerNewsAggregator.Adapters.HTTPHackerNewsHandler
  ],
  hacker_news_url: "https://hacker-news.firebaseio.com/v0/"
