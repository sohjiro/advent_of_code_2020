defmodule AdventOfCode2020.AdapterArray do
  @adapter_jolts 3

  def process(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> prepare_plugs()
    |> filter_joltages()
    |> multiply_distance_one_and_three()
  end

  def prepare_plugs(input) do
    adapter_joltage = Enum.max(input) + @adapter_jolts
    [0, adapter_joltage | input]
    |> Enum.sort()
  end

  def filter_joltages(input) do
    one_distances = one_distance_chunks(input)
    two_distances = two_distance_chunks(input)
    three_distances = three_distance_chunks(input)

    {one_distances, two_distances, three_distances}
  end

  def multiply_distance_one_and_three({one, _two, three}) do
    count_jolt_differences(one) * count_jolt_differences(three)
  end

  def one_distance_chunks(input) do
    Enum.chunk_while(input, [], &one_size_chunk_fun/2, &after_fun/1)
  end

  def two_distance_chunks(input) do
    Enum.chunk_while(input, [], &two_size_chunk_fun/2, &after_fun/1)
  end

  def three_distance_chunks(input) do
    Enum.chunk_while(input, [], &three_size_chunk_fun/2, &after_fun/1)
  end

  def count_jolt_differences(chunked_list) do
    chunked_list
    |> Stream.map(&(&1 |> Enum.count() |> Kernel.-(1)))
    |> Enum.sum()
  end

  defp one_size_chunk_fun(element, []), do: {:cont, [element]}
  defp one_size_chunk_fun(element, [h | _t] = acc) when element - h == 1, do: {:cont, [element | acc]}
  defp one_size_chunk_fun(element, acc), do: {:cont, Enum.reverse(acc), [element]}

  defp two_size_chunk_fun(element, []), do: {:cont, [element]}
  defp two_size_chunk_fun(element, [h | _t] = acc) when element - h == 2, do: {:cont, [element | acc]}
  defp two_size_chunk_fun(element, acc), do: {:cont, Enum.reverse(acc), [element]}

  defp three_size_chunk_fun(element, []), do: {:cont, [element]}
  defp three_size_chunk_fun(element, [h | _t] = acc) when element - h == 3, do: {:cont, [element | acc]}
  defp three_size_chunk_fun(element, acc), do: {:cont, Enum.reverse(acc), [element]}

  defp after_fun([]), do: {:cont, []}
  defp after_fun(acc), do: {:cont, Enum.reverse(acc), []}

end
