defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self, 
      fn (_, send_to) -> spawn(Chain, :counter, [send_to]) end
    send last, 0

    receive do
      final_answer -> "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.inspect :timer.tc(Chain, :create_processes, [n])
  end

  def send_back() do
    receive do
      { pid, token } -> send pid, token
    end
  end

  def run2() do
    fred = spawn(Chain, :send_back, [])
    george = spawn(Chain, :send_back, [])
    send fred, { self(), "fred" }
    send george, { self(), "george" }

    receive do
      token -> IO.inspect token
    end 
    receive do
      token -> IO.inspect token
    end 
  end
end
