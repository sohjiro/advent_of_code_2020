defmodule AdventOfCode2020.HandheldHaltingTest do
  use ExUnit.Case
  alias AdventOfCode2020.HandheldHalting

  test "should get current counter for instructions" do
    input()
    |> Enum.take(1)
    |> HandheldHalting.process_instructions()
    |> validate_result({:done, ["nop +0"], 1, [0], 0})
    |> HandheldHalting.accumulator_value()
    |> validate_result(0)

    input()
    |> Enum.take(2)
    |> HandheldHalting.process_instructions()
    |> validate_result({:done, ["nop +0", "acc +1"], 2, [1, 0], 1})
    |> HandheldHalting.accumulator_value()
    |> validate_result(1)

    input()
    |> Enum.take(7)
    |> HandheldHalting.process_instructions()
    |> validate_result({:done, ["nop +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1"], 7, [6, 2, 1, 0], 2})
    |> HandheldHalting.accumulator_value()
    |> validate_result(2)

    input()
    |> HandheldHalting.process_instructions()
    |> validate_result({:stop, input(), 1, [4, 3, 7, 6, 2, 1, 0], 5})
    |> HandheldHalting.accumulator_value()
    |> validate_result(5)
  end

  test "should get the complete path until the end of the road" do
    input()
    |> HandheldHalting.fix_instructions()
    |> validate_result(expected_ouputs())
    |> HandheldHalting.accumulator_for_fixed_values()
    |> validate_result(8)
  end

  defp input do
    [
      "nop +0",
      "acc +1",
      "jmp +4",
      "acc +3",
      "jmp -3",
      "acc -99",
      "acc +1",
      "jmp -4",
      "acc +6"
    ]
  end

  defp expected_ouputs do
    [
      {:stop, ["jmp +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1",
        "jmp -4", "acc +6"], 0, [0], 0},
      {:stop, ["nop +0", "acc +1", "nop +4", "acc +3", "jmp -3", "acc -99", "acc +1",
        "jmp -4", "acc +6"], 1, [4, 3, 2, 1, 0], 4},
      {:stop, ["nop +0", "acc +1", "jmp +4", "acc +3", "nop -3", "acc -99", "acc +1",
        "jmp -4", "acc +6"], 6, [5, 4, 3, 7, 6, 2, 1, 0], -94},
      {:done,
        ["nop +0", "acc +1", "jmp +4", "acc +3", "jmp -3", "acc -99", "acc +1",
          "nop -4", "acc +6"], 9, [8, 7, 6, 2, 1, 0], 8}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

