defmodule AdventOfCode2020.PasswordPhilosofy do

  def process(text) do
    text
    |> convert_into_rules()
    |> apply_rules()
    |> total_of_valid_passwords()
  end

  def process_two(text) do
    text
    |> convert_into_rules()
    |> apply_new_rules()
    |> total_of_valid_passwords()
  end

  def convert_into_rules(data) do
    Enum.map(data, &extract_info/1)
  end

  def extract_info(data) do
    [size, character, string] = break_down(data, " ")

    {min, max} = get_size_info(size)
    char = get_character(character)
    {min, max, char, to_charlist(string)}
  end

  def apply_rules(rules) do
    Enum.map(rules, fn(rule) ->
      {valid_rule?(rule), rule}
    end)
  end

  def apply_new_rules(rules) do
    Enum.map(rules, fn(rule) ->
      {valid_new_rule?(rule), rule}
    end)

  end

  def total_of_valid_passwords(data) do
    data
    |> Enum.filter(fn({result, _}) -> result end)
    |> Enum.count()
  end

  defp get_size_info(size) do
    [min, max] = break_down(size, "-")
    {String.to_integer(min), String.to_integer(max)}
  end

  defp get_character(character) do
    character
    |> break_down(":", trim: true)
    |> hd()
    |> to_charlist()
    |> hd()
  end

  defp valid_rule?({min, max, char, password}) do
    count_coincidences_for(password, char) in min..max
  end

  defp valid_new_rule?({first, second, char, password}) do
    first_char = Enum.at(password, first - 1)
    second_char = Enum.at(password, second - 1)

    case {first_char == char, second_char == char} do
      {true, false} -> true
      {false, true} -> true
      _ -> false
    end
  end

  defp count_coincidences_for(password, char) do
    password
    |> Enum.filter(&(&1 == char))
    |> Enum.count()
  end

  defp break_down(string, pattern, opts \\ []) do
    String.split(string, pattern, opts)
  end

end
