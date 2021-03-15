defmodule AdventOfCode2021.BinaryBoarding do
  @start 0
  @rows 127
  @cols 7

  def compute_rows(list) do
    Enum.map(list, &add_row_number/1)
  end

  def compute_cols(seats_and_rows) do
    Enum.map(seats_and_rows, &add_col_number/1)
  end

  defp add_row_number(seat_information) do
    {row_seat(seat_information), seat_information}
  end

  defp add_col_number({row, seat_information}) do
    {col_seat(seat_information), row, seat_information}
  end

  defp row_seat(seat_information) do
    seat_information
    |> get_row_information()
    |> to_charlist()
    |> get_row_number(@start, @rows)
  end

  defp col_seat(seat_information) do
    seat_information
    |> get_col_information()
    |> to_charlist()
    |> get_col_number(@start, @cols)
  end

  defp get_row_information(seat_information) do
    split_infomation(seat_information, 0, 7)
  end

  defp get_col_information(seat_information) do
    split_infomation(seat_information, 7, 10)
  end

  defp get_row_number([], number, number), do: number

  defp get_row_number([h | t], first, last) do
    number = (first + last) / 2
    case h do
      ?F ->
        get_row_number(t, first, trunc(number))

      ?B ->
        get_row_number(t, round(number), last)
    end
  end

  defp get_col_number([], number, number), do: number

  defp get_col_number([h | t], first, last) do
    number = (first + last) / 2
    case h do
      ?L ->
        get_col_number(t, first, trunc(number))

      ?R ->
        get_col_number(t, round(number), last)
    end
  end

  defp split_infomation(seat_information, start, len) do
    String.slice(seat_information, start, len)
  end

end
