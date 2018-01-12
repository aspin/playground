defmodule Multiple do
  def parent() do
    spawn_monitor(Multiple, :child, [ self() ])
    :timer.sleep(500)
    receive do
      m -> IO.inspect m
    end
  end

  def child(pid) do
    send pid, "hello"
    exit(:boom)
  end

  def listen() do
    receive do
      m -> IO.inspect m
    end
    listen()
  end
end
