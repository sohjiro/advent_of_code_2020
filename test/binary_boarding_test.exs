defmodule AdventOfCode2021.ReportRepairTest do
  use ExUnit.Case
  alias AdventOfCode2021.BinaryBoarding

  test "get rows from the seat infomation" do
    input()
    |> BinaryBoarding.compute_rows()
    |> validate_result(expected_rows())
  end

  test "get cols from the seat information" do
    input()
    |> BinaryBoarding.compute_rows()
    |> validate_result(expected_rows())
    |> BinaryBoarding.compute_cols()
    |> validate_result(expected_cols())
  end

  defp input do
    ~w(FBFBBFFRLR BFFFBBFRRR FFFBBBFRRR BBFFBBFRLL)
  end

  defp expected_rows do
    [
      {44, "FBFBBFFRLR"},
      {70, "BFFFBBFRRR"},
      {14, "FFFBBBFRRR"},
      {102, "BBFFBBFRLL"}
    ]
  end

  defp expected_cols do
    [
      {5, 44, "FBFBBFFRLR"},
      {7, 70, "BFFFBBFRRR"},
      {7, 14, "FFFBBBFRRR"},
      {4, 102, "BBFFBBFRLL"}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

