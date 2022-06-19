defmodule HackerNewsAggregatorWeb.Views.ItemView do
  use HackerNewsAggregatorWeb, :view

  def render("item.json", %{item: item}) do
    %{
      "id" => item.id,
      "by" => item.by,
      "descendants" => item.descendants,
      "kids" => item.kids,
      "score" => item.score,
      "time" => item.time,
      "title" => item.title,
      "type" => item.type,
      "url" => item.url
    }
  end

  def render("items.json", %{items: items}) do
    render_many(items, __MODULE__, "item.json")
  end
end
