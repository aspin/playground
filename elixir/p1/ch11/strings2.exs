defmodule MoreStrings do
  def parse_shipments(file_path) do
    file = File.open(file_path)
    headers = IO.read(file, :line)
    shipments = IO.stream(file, :line)
    Enum.map(shipments, fn shipment_string ->
      # zip headers with parsed shipment
    end)
  end
end
