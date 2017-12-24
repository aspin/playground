defmodule Arithmetic do
  def sum(1), do: 1
  def sum(n), do: sum(n - 1) + n

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
