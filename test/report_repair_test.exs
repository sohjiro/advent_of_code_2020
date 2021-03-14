defmodule AdventOfCode2021.ReportRepairTest do
  use ExUnit.Case
  alias AdventOfCode2021.ReportRepair

  test "create tuple from inputs" do
    assert expected_tuples == ReportRepair.generate_tuples(input())
  end


  defp input do
    ["1721", "979", "366", "299", "675", "1456"]
  end

  defp expected_tuples do
    [
      {1721, 979},
      {1721, 366},
      {1721, 299},
      {1721, 675},
      {1721, 1456},
      {979, 366},
      {979, 299},
      {979, 675},
      {979, 1456},
      {366, 299},
      {366, 675},
      {366, 1456},
      {299, 675},
      {299, 1456},
      {675, 1456}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

