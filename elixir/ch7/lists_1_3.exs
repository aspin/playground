defmodule ListLearning do
  def mapsum(list, func), do: _mapsum(list, 0, func)
  defp _mapsum([], sum, _func), do: sum
  defp _mapsum([ head | tail ], sum, func) do
    _mapsum(tail, sum + func.(head), func)
  end

  def list_max(array), do: _list_max(array, -999)
  defp _list_max([], max_so_far), do: max_so_far
  defp _list_max([ head | tail ], max_so_far), do: _list_max(tail, _max(head, max_so_far))
  defp _max(one, two) when one >= two, do: one
  defp _max(one, two) when one < two, do: two

  def caesar([], _shift), do: []
  def caesar([ head | tail ], shift) when head + shift <= ?z do
    [ head + shift | caesar(tail, shift) ]
  end
  def caesar([ head | tail ], shift) when head + shift > ?z do
    [ head + shift - 26 | caesar(tail, shift) ]
  end
end
