defmodule AdventOfCode2021.PassportProcessing do
  @keys_length 7
  @year_exp ~r/^[[:digit:]]{4}$/
  @pid_exp ~r/^[[:digit:]]{9}$/
  @hex_color_exp ~r/^#(?:[0-9a-fA-F]{3}){1,2}$/
  @rules [
    {"byr", {:year, 1920..2020}},
    {"iyr", {:year, 2010..2020}},
    {"eyr", {:year, 2020..2030}},
    {"hgt", :height},
    {"hcl", :hair},
    {"ecl", {:eyes, ~w(amb blu brn gry grn hzl oth)}},
    {"pid", :pid}
  ]

  def process(text) do
    text
    |> collect_passport_information()
    |> generate_passport()
    |> verify_passport_information()
    |> count_valid_passports()
  end

  def process_two(text) do
    text
    |> collect_passport_information()
    |> generate_passport()
    |> verify_passport_information_extended()
    |> count_valid_passports()
  end

  def collect_passport_information(enum) do
    enum
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.map(&Enum.join(&1, " "))
    |> Enum.filter(&(&1 !== ""))
  end

  def generate_passport(info) do
    Enum.map(info, &to_map/1)
  end

  def verify_passport_information(info) do
    Enum.map(info, &verify_passport/1)
  end

  def verify_passport_information_extended(info) do
    Enum.map(info, &verify_passport_extended/1)
  end

  def count_valid_passports(passports) do
    passports
    |> Stream.filter(fn({valid, _}) -> valid end)
    |> Enum.count()
  end

  defp to_map(row) do
    row
    |> String.split(" ")
    |> Enum.into(%{}, &generate_key_value/1)
  end

  defp generate_key_value(record) do
    [key, value] = String.split(record, ":")
    {key, value}
  end

  defp verify_passport(passport) do
    {has_required_keys?(passport), passport}
  end

  def verify_passport_extended(passport) do
    status =
      @rules
      |> Enum.into(%{}, fn({field, _} = rule) ->
        status = apply_rule(rule, passport)
        {field, status}
      end)
      |> Map.values()
      |> Enum.all?()

    {status, passport}
  end

  defp has_required_keys?(passport) do
    keys_length(passport) === @keys_length
  end

  defp keys_length(passport) do
    passport
    |> Map.keys()
    |> Kernel.--(["cid"])
    |> Enum.count()
  end

  defp apply_rule({field, data}, passport) do
    case Map.fetch(passport, field) do
      {:ok, value} ->
        valid_rule(value, data)

      :error ->
        false
    end
  end

  defp valid_rule(value, {:year, range}) do
    if Regex.match?(@year_exp, value) do
      String.to_integer(value) in range
    else
      false
    end
  end

  defp valid_rule(value, :height) do
    case String.slice(value, -2, 2) do
      "cm" ->
        value
        |> String.replace("cm", "")
        |> String.to_integer()
        |> Kernel.in(150..193)

      "in" ->
        value
        |> String.replace("in", "")
        |> String.to_integer()
        |> Kernel.in(59..76)

      _ ->
        false
    end
  end

  defp valid_rule(value, :hair) do
    Regex.match?(@hex_color_exp, value)
  end

  defp valid_rule(value, {:eyes, list}) do
    value in list
  end

  defp valid_rule(value, :pid) do
    Regex.match?(@pid_exp, value)
  end

end
