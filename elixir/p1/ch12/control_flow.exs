defmodule ControlFlow do
  def ok!({:ok, data}), do: data
  def ok!(anything), do: raise anything
end
