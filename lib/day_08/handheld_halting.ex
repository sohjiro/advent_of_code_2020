defmodule AdventOfCode2020.HandheldHalting do
  @index 0

  def process(input) do
    input
    |> process_instructions()
    |> accumulator_value()
  end

  def process_instructions(instructions) do
    follow_instructions(instructions, @index, [], 0)
  end

  def accumulator_value({_, _, _, acc}), do: acc

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

  defp convert_instruction(_), do: :stop

  defp execute(:stop, instructions, index, marked, acc) do
    {instructions, index, marked, acc}
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

end
