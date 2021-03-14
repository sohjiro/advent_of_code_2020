defmodule AdventOfCode2021.ReportRepairTest do
  use ExUnit.Case
  alias AdventOfCode2021.ReportRepair

  test "create tuple from inputs" do
    input()
    |> ReportRepair.generate_tuples()
    |> validate_result(expected_tuples())
  end

  test "sum each pair of tuple" do
    input()
    |> ReportRepair.generate_tuples()
    |> validate_result(expected_tuples())
    |> ReportRepair.sum_pairs()
    |> validate_result(expected_tuples_results())
  end

  test "find pair of data and multiply it" do
    input()
    |> ReportRepair.generate_tuples()
    |> validate_result(expected_tuples())
    |> ReportRepair.sum_pairs()
    |> validate_result(expected_tuples_results())
    |> ReportRepair.find_result(2020)
    |> validate_result(expected_tuple())
    |> ReportRepair.multiply_tuple()
    |> validate_result(514_579)
  end

  defp input do
    ["1721", "979", "366", "299", "675", "1456"]
  end

  defp expected_tuples do
    [
      [1721, 979],
      [1721, 366],
      [1721, 299],
      [1721, 675],
      [1721, 1456],
      [979, 366],
      [979, 299],
      [979, 675],
      [979, 1456],
      [366, 299],
      [366, 675],
      [366, 1456],
      [299, 675],
      [299, 1456],
      [675, 1456]
    ]
  end

  defp expected_tuples_results do
    [
      {1721, 979, 2700},
      {1721, 366, 2087},
      {1721, 299, 2020},
      {1721, 675, 2396},
      {1721, 1456, 3177},
      {979, 366, 1345},
      {979, 299, 1278},
      {979, 675, 1654},
      {979, 1456, 2435},
      {366, 299, 665},
      {366, 675, 1041},
      {366, 1456, 1822},
      {299, 675, 974},
      {299, 1456, 1755},
      {675, 1456, 2131}
    ]
  end

  defp expected_tuple do
    {1721, 299, 2020}
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

