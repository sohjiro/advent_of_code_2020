defmodule AdventOfCode2021.PassportProcessing do
  @keys_length 7

  def process(text) do
    text
    |> collect_passport_information()
    |> generate_passport()
    |> verify_passport_information()
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

  defp has_required_keys?(passport) do
    keys_length(passport) === @keys_length
  end

  defp keys_length(passport) do
    passport
    |> Map.keys()
    |> Kernel.--(["cid"])
    |> Enum.count()
  end

end
