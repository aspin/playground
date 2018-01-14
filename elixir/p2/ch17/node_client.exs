defmodule NodeClient do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    NodeServer.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock"
    end
    receiver()
  end
end
