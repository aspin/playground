defmodule Stack.Server do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:pop, _from, [ head | tail ]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, element}, state) when element < 10 do
    System.halt(element)
  end

  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  #  def terminate(reason, state) do
  #    IO.inspect reason
  #    IO.inspect state
  #  end
end
