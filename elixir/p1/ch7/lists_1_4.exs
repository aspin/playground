# needs to compare

defmodule MyList do
  def span(array, from, to), do: _span(array, from, to, 0)

  defp _span([], _, _, _), do: []

  defp _span([ head | tail ], from, to, current) when current >= from and current < to do
    [ head ] ++ _span(tail, from, to, current + 1)
  end

  defp _span([ _head | tail ], from, to, current), do: _span(tail, from, to, current + 1)
end
