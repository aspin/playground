defmodule Guesser do
  def guess(actual, low..high) do
    guess_number(div(high - low, 2) + low, actual, low..high)
  end

  def guess_number(number, actual, _) when actual == number do
    IO.puts "Is it #{number}"
  end

  def guess_number(number, _, low..high) when number == high or number == low do
    IO.puts "Invalid range"
  end

  def guess_number(number, actual, _..high) when actual > number do
    IO.puts "Is it #{number}"
    guess_number(div(high - number, 2) + number, actual, number..high)
  end

  def guess_number(number, actual, low.._) when actual < number do
    IO.puts "Is it #{number}"
    guess_number(div(number - low, 2) + low, actual, low..number)
  end
end
