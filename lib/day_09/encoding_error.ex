defmodule AdventOfCode2020.EncodingError do
  @default_size 25

  def process(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> xmas_verify()
  end

  def process_two(input) do
    {:invalid, weakness} = process(input)

    input
    |> Enum.map(&String.to_integer/1)
    |> break_xmas_encryption(weakness)
    |> encryption_weakness()
    |> find_weaknes()
  end

  def xmas_verify(list, slice \\ @default_size)

  def xmas_verify([], _slice), do: :valid

  def xmas_verify(list, slice) do
    {current_list, to_test} = Enum.split(list, slice)
    run_verification(current_list, to_test, slice)
  end

  def xmas_valid_number?(list, number) do
    list
    |> combine()
    |> List.keymember?(number, 2)
  end

  def break_xmas_encryption(input, number) do
    {elements, ^number} = sum_for_contiguous_numbers(input, number)
    {input, number, elements}
  end

  def encryption_weakness({input, number, elements}) do
    weakness = Enum.max(elements) + Enum.min(elements)

    {input, number, elements, weakness}
  end

  def find_weaknes({_input, _number, _elements, weakness}), do: weakness

  defp run_verification(current_list, [], _slice), do: {:valid, current_list}
  defp run_verification(current_list, [number | t], slice) do
    list = Enum.slice(current_list, slice * -1, slice)

    if xmas_valid_number?(list, number) do
      run_verification(current_list ++ [number], t, slice)
    else
      {:invalid, number}
    end
  end

  defp combine([]), do: []

  defp combine([h | t]) do
    (for l <- t, do: {h, l, h + l}) ++ combine(t)
  end

  defp sum_for_contiguous_numbers([h | t], number) do
    case do_sum(h, t, number, [h]) do
      :not_found ->
        sum_for_contiguous_numbers(t, number)

      {:found, elements} ->
        {elements, number}

      _ ->
        :error
    end
  end

  defp do_sum(_acc, [], _searched, _elements), do: :error

  defp do_sum(acc, _, searched, _elements) when acc > searched, do: :not_found

  defp do_sum(acc, _, searched, elements) when acc == searched, do: {:found, elements}

  defp do_sum(acc, [h | t], searched, elements) do
    do_sum(acc + h, t, searched, [h | elements])
  end

  # defp sum_for_contiguous_numbers(numbers, number) do
  #   case do_sum(numbers, number) do
  #     {:not_found, _, _} ->
  #       numbers
  #       |> tl()
  #       |> sum_for_contiguous_numbers(number)
  #     {:found, value, elements} ->
  #       {elements, value}
  #   end
  # end

  # defp do_sum(numbers, number) do
  #   Enum.reduce_while(numbers, {0, []}, fn(x, {acc, elements}) ->
  #     value = x + acc
  #     cond do
  #       value < number ->
  #         {:cont, {value, [x | elements]}}

  #       value > number ->
  #         {:halt, {:not_found, value, [x | elements]}}

  #       true ->
  #         {:halt, {:found, value, [x | elements]}}
  #     end
  #   end)
  # end

end
