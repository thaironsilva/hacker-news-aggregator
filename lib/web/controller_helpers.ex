defmodule HackerNewsAggregatorWeb.ControllerHelpers do
  @moduledoc """
  Helpers for controllers
  """

  alias Plug.Conn

  @spec validate_page(any) :: {:error, :invalid_page} | {:ok, integer}
  def validate_page(nil), do: {:ok, 1}

  def validate_page(page) do
    cond do
      page < 1 -> {:error, :invalid_page}
      true -> {:ok, page}
    end
  end

  @spec integer_parser(binary()) :: {atom(), integer()}
  def integer_parser(nil), do: {:ok, 1}

  def integer_parser(n) do
    case Integer.parse(n) do
      :error ->
        {:error, :invalid_number}

      {valid, _} ->
        {:ok, valid}
    end
  end

  @spec put_content_range(Conn.t(), integer(), integer()) :: Conn.t()
  def put_content_range(conn, page, total) do
    Conn.put_resp_header(conn, "content-range", "#{render_range(page)}/#{total}")
  end

  defp render_range(page), do: "#{page * 10 - 9}-#{page * 10}"
end
