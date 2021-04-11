defmodule AdventOfCode2020.EncodingErrorTest do
  use ExUnit.Case
  alias AdventOfCode2020.EncodingError

  test "valid number" do
    input()
    |> EncodingError.xmas_valid_number?(26)
    |> validate_result(true)
  end

  test "should add number to list if is a valid one" do
    input(1, 26)
    |> EncodingError.xmas_verify()
    |> validate_result({:valid, input(1, 26)})
  end

  test "should not add number to list when is not valid" do
    input(1, 26)
    |> Enum.concat([100])
    |> EncodingError.xmas_verify()
    |> validate_result({:invalid, 100})
  end

  test "should process more than 25 numbers and find wrong number" do
    value = input(1, 26) |> Enum.concat([100])

    value
    |> EncodingError.xmas_verify()
    |> validate_result({:invalid, 100})
  end

  test "should process in a fixed value" do
    second_input()
    |> EncodingError.xmas_verify(5)
    |> validate_result({:invalid, 127})
  end

  test "find contiguous set of at least two numbers which sum the invalid number" do
    second_input()
    |> EncodingError.break_xmas_encryption(127)
    |> validate_result({second_input(), 127, [40, 47, 25, 15]})
    |> EncodingError.encryption_weakness()
    |> validate_result({second_input(), 127, [40, 47, 25, 15], 62})
    |> EncodingError.find_weaknes()
    |> validate_result(62)
  end

  defp input(first \\ 1, last \\ 25)do
    Enum.to_list(first..last)
  end

  defp second_input do
    [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

