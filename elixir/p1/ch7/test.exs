defmodule Test do
  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def sum([]), do: 0
  def sum([ head | tail ]), do: head + sum(tail)
end
