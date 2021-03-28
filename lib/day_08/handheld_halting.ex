defmodule AdventOfCode2020.HandheldHalting do
  @index 0
  @filtering_instructions ~w[nop jmp]

  def process(input) do
    input
    |> process_instructions()
    |> accumulator_value()
  end

  def process_two(input) do
    input
    |> fix_instructions()
    |> accumulator_for_fixed_values()
  end

  def process_instructions(instructions) do
    follow_instructions(instructions, @index, [], 0)
  end

  def fix_instructions(instructions) do
    filters = jmp_nop_instructions(instructions)
    for {instruction, index} <- filters do
      instructions
      |> List.replace_at(index, invert_instruction(instruction))
      |> follow_instructions(@index, [], 0)
    end
  end

  def accumulator_for_fixed_values(instructions) do
    {:done, _, _, _, acc} = List.keyfind(instructions, :done, 0)
    acc
  end

  def accumulator_value({_, _, _, _, acc}), do: acc

  def follow_instructions(instructions, index, marked, acc) do
    if index in marked do
      # IO.inspect index, label: "index"
      # IO.inspect hd(marked), label: "hd(marked)"
      execute(:stop, instructions, index, marked, acc)
    else
      instructions
      |> take_at(index)
      |> convert_instruction()
      |> execute(instructions, index, marked, acc)
    end
  end

  defp take_at(instructions, index), do: Enum.at(instructions, index)

  defp convert_instruction(<<instruction :: binary-size(3), " ", rest :: binary>>) do
    {instruction, String.to_integer(rest)}
  end

  defp convert_instruction(_), do: :done

  defp execute(:stop, instructions, index, marked, acc) do
    {:stop, instructions, index, marked, acc}
  end

  defp execute(:done, instructions, index, marked, acc) do
    {:done, instructions, index, marked, acc}
  end

  defp execute({command, value}, instructions, index, marked, acc) do
    case command do
      "nop" ->
        follow_instructions(instructions, index + 1, [index | marked], acc)

      "acc" ->
        follow_instructions(instructions, index + 1, [index | marked], acc + value)

      "jmp" ->
        follow_instructions(instructions, index + value, [index | marked], acc)
    end
  end

  defp jmp_nop_instructions(instructions) do
    instructions
    |> Stream.with_index()
    |> Stream.filter(&contains_filtering_instructions?/1)
  end

  defp contains_filtering_instructions?({instruction, _index}) do
    String.slice(instruction, 0, 3) in @filtering_instructions
  end

  def invert_instruction("nop" <> rest), do: "jmp" <> rest
  def invert_instruction("jmp" <> rest), do: "nop" <> rest

end
