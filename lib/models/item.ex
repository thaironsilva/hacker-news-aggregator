defmodule HackerNewsAggregator.Models.Item do
  @moduledoc """
  Embedded schema that represents a generic Item from Hacker News API
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false

  @fields [:by, :descendants, :id, :kids, :score, :time, :title, :type, :url]

  embedded_schema do
    field(:id, :integer)
    field(:by, :string)
    field(:descendants, :integer)
    field(:kids, {:array, :integer})
    field(:score, :integer)
    field(:time, :integer)
    field(:title, :string)
    field(:type, :string)
    field(:url, :string)
  end

  def changeset(schema \\ %__MODULE__{}, filters) do
    cast(schema, filters, @fields)
  end
end
