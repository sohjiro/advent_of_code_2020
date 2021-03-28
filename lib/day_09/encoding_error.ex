defmodule AdventOfCode2020.EncodingError do
  @default_size 25

  def process(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> xmas_verify()
  end

  def process_two(input) do
    input
  end

  def xmas_verify(list, slice \\ @default_size)

  def xmas_verify([], _slice), do: :valid

  def xmas_verify(list, slice) do
    {current_list, to_test} = Enum.split(list, slice)
    run_verification(current_list, to_test, slice)
  end

  defp run_verification(current_list, [], _slice), do: {:valid, current_list}
  defp run_verification(current_list, [number | t], slice) do
    list = Enum.slice(current_list, slice * -1, slice)

    if xmas_valid_number?(list, number) do
      run_verification(current_list ++ [number], t, slice)
    else
      {:invalid, number}
    end
  end

  def xmas_valid_number?(list, number) do
    list
    |> combine()
    |> List.keymember?(number, 2)
  end

  defp combine([]), do: []

  defp combine([h | t]) do
    (for l <- t, do: {h, l, h + l}) ++ combine(t)
  end

end
