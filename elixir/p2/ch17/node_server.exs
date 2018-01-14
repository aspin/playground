defmodule NodeServer do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, queue) do
    receive do
      { :register, pid } -> 
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], queue)
    after
      @interval ->
        IO.puts "tick"
        case queue do
          [ head | tail ] -> 
            send head, {:tick}
            generator(clients, tail)
          _ ->
            if !Enum.empty? clients do
              [ head | tail ] = clients
              send head, {:tick}
              generator(clients, tail)
            else
              generator(clients, queue)
            end
        end
    end
  end
end
