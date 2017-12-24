defmodule MyList do
  def all?([], _predicate), do: true
  def all?([ head | tail ], predicate), do: predicate.(head) and all?(tail, predicate)

  def each([], _consumer), do: []
  def each([ head | tail ], consumer), do: [ consumer.(head) | each(tail, consumer) ]

  def filter([], _predicate), do: []
  def filter([ head | tail ], predicate) do
    if predicate.(head) do
      [ head | filter(tail, predicate) ]
    else
      [ filter(tail, predicate) ]
    end
  end

  def split(list, index) do
    _split(list, [], index, 0)
  end
  defp _split([], front, _, _), do: [front, []]
  defp _split(list, front, index, _) when length(front) >= index, do: [front, list]
  defp _split([ head | tail ], front, index, iter) do
    _split(tail, Enum.reverse([ head | front]), index, iter + 1)
  end

  def flatten(list), do: _flatten(list, [])
  defp _flatten([], list), do: list
  defp _flatten([ head | tail ], list) when is_list(head) do
    _flatten(head, _flatten(tail, []))
  end
  defp _flatten([ head | tail ], list), do: [ head | _flatten(tail, list) ]
end
