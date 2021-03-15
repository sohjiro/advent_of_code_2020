defmodule AdventOfCode2020.BinaryBoardingTest do
  use ExUnit.Case
  alias AdventOfCode2020.BinaryBoarding

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

  test "add seats id" do
    input()
    |> BinaryBoarding.compute_rows()
    |> validate_result(expected_rows())
    |> BinaryBoarding.compute_cols()
    |> validate_result(expected_cols())
    |> BinaryBoarding.compute_id_seats()
    |> validate_result(expected_id_seats())
  end

  test "get highest seat id" do
    input()
    |> BinaryBoarding.compute_rows()
    |> validate_result(expected_rows())
    |> BinaryBoarding.compute_cols()
    |> validate_result(expected_cols())
    |> BinaryBoarding.compute_id_seats()
    |> validate_result(expected_id_seats())
    |> BinaryBoarding.highest_seat_id()
    |> validate_result({820, 4, 102, "BBFFBBFRLL"})
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

  defp expected_id_seats do
    [
      {357, 5, 44, "FBFBBFFRLR"},
      {567, 7, 70, "BFFFBBFRRR"},
      {119, 7, 14, "FFFBBBFRRR"},
      {820, 4, 102, "BBFFBBFRLL"}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

