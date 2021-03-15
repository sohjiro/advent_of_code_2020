defmodule AdventOfCode2021.CustomCustoms do

  def process(text) do
    text
    |> generate_groups()
    |> count_yes_answers_per_group()
    |> total_yes_answers()
  end

  def generate_groups(enum) do
    Enum.chunk_by(enum, &(&1 == ""))
  end

  def count_yes_answers_per_group(groups) do
    Enum.map(groups, &process_group_information/1)
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

end

