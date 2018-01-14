defmodule RingNode do
  @name :master

  def start do
    case :global.whereis_name(@name) do
      :undefined ->
        pid = spawn(__MODULE__, :listener, [nil, nil])
        :global.register_name(@name, pid)
      master ->
        pid = spawn(__MODULE__, :listener, [master, nil])
        send master, {:register, pid}
    end
  end

  def listener(nil, nil) do
    spawn(__MODULE__, :timeout, [self()])
    listener(self(), self())
  end

  def listener(next, tail) do
    next_pid = next
    receive do
      :tock ->
        IO.puts "tock"
        send next, :tick
        listener(next_pid, tail)
      :tick ->
        spawn(__MODULE__, :timeout, [self()])
        listener(next_pid, tail)
      {:register, new_pid} ->
        send tail, {:change, new_pid}
        listener(next_pid, new_pid)
      {:change, new_pid} ->
        listener(new_pid, tail)
    end
  end

  def timeout(host_pid) do
    receive do
      _ -> nil
    after
      2000 -> send host_pid, :tock
    end
  end
end
