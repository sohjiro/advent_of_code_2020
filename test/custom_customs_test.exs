defmodule AdventOfCode2021.CustomCustomsTest do
  use ExUnit.Case
  alias AdventOfCode2021.CustomCustoms

  test "should parse information from a group" do
    expected = basic_input()

    two_groups_input()
    |> CustomCustoms.generate_groups()
    |> validate_result([expected, [""], expected])
  end

  test "Count yes answers" do
    expected = ["abcx", "abcy", "abcz"]

    basic_input()
    |> CustomCustoms.generate_groups()
    |> validate_result([expected])
    |> CustomCustoms.count_yes_answers_per_group()
    |> validate_result([6])
  end

  test "should collect information from multiple groups" do
    expected = ["abcx", "abcy", "abcz"]

    two_groups_input()
    |> CustomCustoms.generate_groups()
    |> validate_result([expected, [""], expected])
    |> CustomCustoms.count_yes_answers_per_group()
    |> validate_result([6, 0, 6])
    |> CustomCustoms.total_yes_answers()
    |> validate_result(12)
  end

  defp two_groups_input do
    basic_input() ++ ["" | basic_input()]
  end

  defp basic_input do
    ["abcx", "abcy", "abcz"]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end
