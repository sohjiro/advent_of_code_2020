defmodule AdventOfCode2020.PasswordPhilosofyTest do
  use ExUnit.Case
  alias AdventOfCode2020.PasswordPhilosofy

  test "extract password information" do
    basic_input()
    |> hd()
    |> PasswordPhilosofy.extract_info()
    |> validate_result(hd(expected()))
  end

  test "extract all information from source" do
    basic_input()
    |> PasswordPhilosofy.convert_into_rules()
    |> validate_result(expected())
  end

  test "apply rules in each password string" do
    basic_input()
    |> PasswordPhilosofy.convert_into_rules()
    |> validate_result(expected())
    |> PasswordPhilosofy.apply_rules()
    |> validate_result(expected_rules())
  end

  test "total of valid passwords" do
    basic_input()
    |> PasswordPhilosofy.convert_into_rules()
    |> validate_result(expected())
    |> PasswordPhilosofy.apply_rules()
    |> validate_result(expected_rules())
    |> PasswordPhilosofy.total_of_valid_passwords()
    |> validate_result(2)
  end

  test "valid passwords for second day" do
    basic_input()
    |> PasswordPhilosofy.convert_into_rules()
    |> validate_result(expected())
    |> PasswordPhilosofy.apply_new_rules()
    |> validate_result(expected_new_rules())
    |> PasswordPhilosofy.total_of_valid_passwords()
    |> validate_result(1)
  end

  defp basic_input do
    ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
  end

  defp expected do
    [
      {1, 3, ?a, 'abcde'},
      {1, 3, ?b, 'cdefg'},
      {2, 9, ?c, 'ccccccccc'}
    ]
  end

  defp expected_rules do
    [
      {true, {1, 3, ?a, 'abcde'}},
      {false, {1, 3, ?b, 'cdefg'}},
      {true, {2, 9, ?c, 'ccccccccc'}}
    ]
  end

  defp expected_new_rules do
    [
      {true, {1, 3, ?a, 'abcde'}},
      {false, {1, 3, ?b, 'cdefg'}},
      {false, {2, 9, ?c, 'ccccccccc'}}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

