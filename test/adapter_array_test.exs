defmodule AdventOfCode2020.AdapterArrayTest do
  use ExUnit.Case
  alias AdventOfCode2020.AdapterArray

  test "add charging outleat and built-in joltage" do
    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
  end

  test "count jolt differences" do
    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
    |> AdapterArray.one_distance_chunks()
    |> validate_result(expected_one_distance_small_input())
    |> AdapterArray.count_jolt_differences()
    |> validate_result(7)

    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
    |> AdapterArray.two_distance_chunks()
    |> validate_result(expected_two_distance_small_input())
    |> AdapterArray.count_jolt_differences()
    |> validate_result(0)

    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
    |> AdapterArray.three_distance_chunks()
    |> validate_result(expected_three_distance_small_input())
    |> AdapterArray.count_jolt_differences()
    |> validate_result(5)
  end

  test "larger example" do
    larger_input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_larger_input())
    |> AdapterArray.filter_joltages()
    |> validate_result(expected_filtered_joltages())
    |> AdapterArray.multiply_distance_one_and_three()
    |> validate_result(220)
  end

  test "create nodes for elements" do
    [0, 1]
    |> AdapterArray.generate_nodes()
    |> validate_result(expected_nodes())

    [0, 1, 4]
    |> AdapterArray.generate_nodes()
    |> validate_result(expected_multipe_nodes())

    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
    |> AdapterArray.generate_nodes()
    |> validate_result(expected_input_nodes())
  end

  test "generate children's paths" do
    expected_input_nodes()
    |> AdapterArray.children_paths_total(22)
    |> validate_result(%{22 => 1})

    expected_input_nodes()
    |> AdapterArray.children_paths_total(19, %{22 => 1})
    |> validate_result(Map.take(expected_total_children_paths(), [19, 22]))

    expected_input_nodes()
    |> AdapterArray.children_paths_total(16, Map.take(expected_total_children_paths(), [19, 22]))
    |> validate_result( Map.take(expected_total_children_paths(), [16, 19, 22]))

    expected_input_nodes()
    |> AdapterArray.children_paths_total(4, Map.drop(expected_total_children_paths(), [0, 1, 4]))
    |> validate_result(Map.drop(expected_total_children_paths(), [0, 1]))

    expected_input_nodes()
    |> AdapterArray.children_paths_total(0, Map.drop(expected_total_children_paths(), [0]))
    |> validate_result(expected_total_children_paths())

    input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_joltages())
    |> AdapterArray.generate_nodes()
    |> validate_result(expected_input_nodes())
    |> AdapterArray.prepare_children()
    |> validate_result(expected_total_children_paths())

    larger_input()
    |> AdapterArray.prepare_plugs()
    |> validate_result(expected_larger_input())
    |> AdapterArray.generate_nodes()
    |> AdapterArray.prepare_children()
    |> Map.get(0)
    |> validate_result(19_208)
  end

  defp input do
    [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
  end

  defp expected_joltages do
    [0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22]
  end

  defp expected_one_distance_small_input do
    [
      [0, 1],
      [4, 5, 6, 7],
      [10, 11, 12],
      [15, 16],
      [19],
      [22]
    ]
  end

  defp expected_two_distance_small_input do
    [[0], [1], [4], [5], [6], [7], [10], [11], [12], [15], [16], [19], [22]]
  end

  defp expected_three_distance_small_input do
    [
      [0],
      [1, 4],
      [5],
      [6],
      [7, 10],
      [11],
      [12, 15],
      [16, 19, 22]
    ]
  end

  defp larger_input do
    [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
  end

  def expected_larger_input do
    [0, 52 | larger_input()] |> Enum.sort()
  end

  defp expected_filtered_joltages do
    {
      [
        [0, 1, 2, 3, 4],
        [7, 8, 9, 10, 11],
        [14],
        [17, 18, 19, 20],
        [23, 24, 25],
        [28],
        [31, 32, 33, 34, 35],
        [38, 39],
        [42],
        [45, 46, 47, 48, 49],
        [52]
      ],
      [
        [0], [1], [2], [3], [4],
        [7], [8], [9], [10], [11],
        [14],
        [17], [18], [19], [20],
        [23], [24], [25],
        [28],
        [31], [32], [33], [34], [35],
        [38], [39],
        [42],
        [45], [46], [47], [48], [49],
        [52]
      ],
      [
        [0], [1], [2], [3], [4, 7],
        [8], [9], [10], [11, 14, 17], [18], [19], [20, 23], [24], [25, 28, 31],
        [32], [33], [34], [35, 38], [39, 42, 45], [46], [47], [48], [49, 52]
      ]
    }
  end

  defp expected_nodes, do: %{0 => [1], 1 => []}

  defp expected_multipe_nodes, do: %{0 => [1], 1 => [4], 4 => []}

  defp expected_input_nodes do
    %{
      0 => [1],
      1 => [4],
      4 => [5, 6, 7],
      5 => [6, 7],
      6 => [7],
      7 => [10],
      10 => [11, 12],
      11 => [12],
      12 => [15],
      15 => [16],
      16 => [19],
      19 => [22],
      22 => []
    }
  end

  defp expected_total_children_paths do
    %{0 => 8, 1 => 8, 4 => 8, 5 => 4, 6 => 2, 7 => 2, 10 => 2, 11 => 1, 12 => 1, 15 => 1, 16 => 1, 19 => 1, 22 => 1}
  end

  defp validate_result(result, expected) do
    assert result === expected
    result
  end
end

