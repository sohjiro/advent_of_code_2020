defmodule AdventOfCode2020.CustomCustoms do

  def process(text) do
    text
    |> generate_groups()
    |> count_yes_answers_per_group()
    |> total_yes_answers()
  end

  def process_two(text) do
    text
    |> generate_groups()
    |> count_common_yes_answers_per_group()
    |> total_yes_answers()
  end

  def generate_groups(enum) do
    Enum.chunk_by(enum, &(&1 == ""))
  end

  def count_yes_answers_per_group(groups) do
    Enum.map(groups, &process_group_information/1)
  end

  def count_common_yes_answers_per_group(groups) do
    Enum.map(groups, &process_common_information/1)
  end

  def total_yes_answers(groups) do
    Enum.sum(groups)
  end

  defp process_group_information(group) do
    group
    |> Enum.join()
    |> to_charlist()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp process_common_information(group) do
    group
    |> Enum.map(&wrap_person/1)
    |> count_per_group()
  end

  defp wrap_person(person) do
    person
    |> to_charlist()
    |> MapSet.new()
  end

  defp count_per_group([person]), do: MapSet.size(person)
  defp count_per_group(group) do
    group
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.size()
  end

end

