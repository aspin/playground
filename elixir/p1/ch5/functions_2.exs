fizz_buzz = fn 
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz" 
  _, _, c -> c
end

IO.puts(fizz_buzz.(0, 0, 1))
IO.puts(fizz_buzz.(0, 1, 1))
IO.puts(fizz_buzz.(1, 0, 1))
IO.puts(fizz_buzz.(1, 1, "NotFizzBuzz"))

fizz_buzz2 = fn
  n -> fizz_buzz.(rem(n, 3), rem(n, 5), rem(n, 7))
end

IO.puts fizz_buzz2.(11)
