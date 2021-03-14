defmodule AdventOfCode2021.ReportRepair do
  @tuple_size 2
  @default_result 2020

  def process(text) do
    text
    |> generate_tuples()
    |> sum_pairs()
    |> find_result(@default_result)
    |> multiply_tuple()
  end

  def generate_tuples(numbers) do
    combine(@tuple_size, numbers)
  end

  def sum_pairs(combinations) do
    Enum.map(combinations, fn([x, y]) ->
      {x, y, x + y}
    end)
  end

  def find_result(combinations, result) do
    List.keyfind(combinations, result, 2)
  end

  def multiply_tuple({x, y, _}), do: x * y

  defp combine(0, _), do: [[]]
  defp combine(_, []), do: []
  defp combine(m, [h | t]) do
    (for l <- combine(m - 1, t), do: [String.to_integer(h) | l]) ++ combine(m, t)
  end

end
