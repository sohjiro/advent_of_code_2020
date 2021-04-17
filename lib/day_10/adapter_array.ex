defmodule AdventOfCode2020.AdapterArray do
  @adapter_jolts 3
  @starting_node 0

  def process(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> prepare_plugs()
    |> filter_joltages()
    |> multiply_distance_one_and_three()
  end

  def process_two(input) do
    input
    |> Enum.map(&String.to_integer/1)
    |> prepare_plugs()
    |> generate_nodes()
    # |> count_paths()
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

  def count_jolt_differences(chunked_list) do
    chunked_list
    |> Stream.map(&(&1 |> Enum.count() |> Kernel.-(1)))
    |> Enum.sum()
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

  def generate_nodes(list, acc \\ %{})

  def generate_nodes([], acc), do: acc

  def generate_nodes([h | t], acc) do
    # IO.puts "generate_nodes #{h}"
    acc = Map.put_new_lazy(acc, h, fn ->
      possible_nodes(h, t)
    end)
    # acc = Map.put_new(acc, h, possible_nodes(h, t))
    # acc = Map.put(acc, h, possible_nodes(h, t))

    generate_nodes(t, acc)
  end

  def count_paths(nodes, node \\ @starting_node) do
    nodes
    |> Map.get(node)
    |> paths_for(nodes)
  end

  defp possible_nodes(element, remaining) do
    # IO.inspect "element: #{element}"
    [element + 1, element + 2, element + 3]
    |> MapSet.new()
    |> MapSet.intersection(MapSet.new(remaining))
    |> MapSet.to_list()
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

  defp paths_for([], _nodes), do: 1

  defp paths_for(paths, nodes) do
    IO.inspect paths, label: "paths"
    Enum.reduce(paths, 0, fn(path, acc) ->
      acc + count_paths(nodes, path)
    end)
  end

end
