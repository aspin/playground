defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do 
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end) |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do 
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:cat, next, self()} 
        schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          results
        end
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ result | results ]) 
    end
  end

  def cat_finder(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :cat, arg, client } ->
        send client, { :answer, arg, find_cats(arg), self() }
        cat_finder(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def find_cats(file), do: _find_cats(File.read!(file), 0)

  defp _find_cats(<<>>, count), do: count

  defp _find_cats(<< "cat", tail::binary >>, count), do: _find_cats(tail, count + 1)

  defp _find_cats(<< head::utf8, tail::binary >>, count), do: _find_cats(tail, count)

  def main(directory) do
    IO.inspect File.ls!(directory)
    run(5, Scheduler, :cat_finder, File.ls!(directory))
    |> Enum.sum
  end
end
