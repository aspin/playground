defmodule MyStrings do
  defp _calculate([ head | [] ]), do: head

  defp _calculate([ first, '+', second | tail ]) do
    _calculate([ parse(first) + parse(second) ] ++ tail)
  end

  defp _calculate([ first, '*', second | tail ]) do
    _calculate([ parse(first) * parse(second) ] ++ tail)
  end

  defp _calculate([ first, '-', second | tail ]) do
    _calculate([ parse(first) - parse(second) ] ++ tail)
  end

  defp _calculate([ first, '/', second | tail ]) do
    _calculate([ parse(first) / parse(second) ] ++ tail)
  end

  defp _calculate([ head | tail ]) do
    IO.puts head
    IO.puts tail
    raise "malformed expression"
  end

  def calculate(expression) do
    Kernel.to_string(expression)
      |> String.split(" ")
      |> Enum.map(&(Kernel.to_charlist(&1)))
      |> _calculate
  end

  def parse(char_array) when is_list(char_array) do
    Kernel.to_string(char_array)
      |> String.to_integer
  end

  def parse(number), do: number

  def center(strings) do
    max_length = strings
                 |> Enum.map(&(String.length(&1)))
                 |> Enum.max
    Enum.each(strings, fn s ->
      pad_with_spaces(s, max_length - String.length(s))
    end)
  end

  def pad_with_spaces(string, indent) when rem(indent, 2) === 0 do
    IO.puts(string 
    |> String.pad_leading(round(indent / 2) + String.length(string)))
  end

  def pad_with_spaces(string, indent), do: pad_with_spaces(string, indent - 1)

  def capitalize_sentences(<<>>), do: ""

  def capitalize_sentences(<< ". ", nextchar::utf8, tail::binary >>) do
    ". " <> String.upcase(<< nextchar >>) <> capitalize_sentences(tail)
  end

  def capitalize_sentences(<< head::utf8, tail::binary>>) do
    String.downcase(<< head >>) <> capitalize_sentences(tail)
  end

  def capitalize_sentences(default), do: capitalize_sentences(String.capitalize(default))

end
