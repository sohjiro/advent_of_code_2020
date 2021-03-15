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

  def process_two(text) do
    text
    |> generate_tuples(3)
    |> sum_elements()
    |> find_result(@default_result, 3)
    |> multiply_tuple()
  end

  def generate_tuples(numbers, size \\ @tuple_size) do
    combine(size, numbers)
  end

  def sum_elements(combinations) do
    Enum.map(combinations, fn([x, y, z]) ->
      {x, y, z, x + y + z}
    end)
  end

  def sum_pairs(combinations) do
    Enum.map(combinations, fn([x, y]) ->
      {x, y, x + y}
    end)
  end

  def find_result(combinations, result, position \\ 2) do
    List.keyfind(combinations, result, position)
  end

  def multiply_tuple({x, y, _}), do: x * y
  def multiply_tuple({x, y, z, _}), do: x * y * z

  defp combine(0, _), do: [[]]
  defp combine(_, []), do: []
  defp combine(m, [h | t]) do
    (for l <- combine(m - 1, t), do: [String.to_integer(h) | l]) ++ combine(m, t)
  end

end
