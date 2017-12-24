defmodule MyList do
  def span(from, to) when from >= to, do: []
  def span(from, to), do: [ from | span(from + 1, to) ]

  def prime_numbers(endpoint) do
    range = span(2, endpoint)
    range -- for x <- range, y <- range, x >= y, x * y < endpoint, do: x * y
  end

  taxes = [ NC: 0.075, TX: 0.08 ]
  orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount: 35.50 ],
    [ id: 125, ship_to: :TX, net_amount: 24.00 ],
    [ id: 126, ship_to: :TX, net_amount: 44.80 ],
    [ id: 127, ship_to: :NC, net_amount: 25.00 ],
    [ id: 128, ship_to: :MA, net_amount: 10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount: 50.00 ]
  ]

  def add_taxes(taxes, orders) do
    orders |> Enum.map(fn order ->
      tax = Keyword.get(taxes, order[:ship_to], 0)
      Keyword.put(order, :total_amount, order[:net_amount] * ( 1 + tax ))
    end
    )
  end

end

