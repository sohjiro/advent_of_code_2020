defmodule AdventOfCode2021.BinaryBoarding do
  @start 0
  @rows 127
  @cols 7
  @row_len 7
  @col_len 3
  @upper_half [?B, ?R]
  @lower_half [?F, ?L]
  @seat 8

  def process(input) do
    input
    |> compute_rows()
    |> compute_cols()
    |> compute_id_seats()
    |> highest_seat_id()
  end

  def process_two(input) do
    passenger_seats =
      input
      |> compute_rows()
      |> compute_cols()
      |> compute_id_seats()
      |> Enum.map(fn{id, _, _, _} -> id end)
      |> MapSet.new()

    start = Enum.min(passenger_seats)
    last = Enum.max(passenger_seats)

    start..last
    |> MapSet.new()
    |> MapSet.difference(passenger_seats)
  end

  def compute_rows(list) do
    Enum.map(list, &add_row_number/1)
  end

  def compute_cols(seats_and_rows) do
    Enum.map(seats_and_rows, &add_col_number/1)
  end

  def compute_id_seats(seats_info) do
    Enum.map(seats_info, &add_id_seat/1)
  end

  def highest_seat_id(seats) do
    Enum.max_by(seats, fn({seat_id, _, _, _}) -> seat_id end)
  end

  defp add_row_number(seat_information) do
    {row_seat(seat_information), seat_information}
  end

  defp add_col_number({row, seat_information}) do
    {col_seat(seat_information), row, seat_information}
  end

  defp add_id_seat({col, row, seat_information}) do
    {row * @seat + col, col, row, seat_information}
  end

  defp row_seat(seat_information) do
    seat_information
    |> get_information(@start, @row_len)
    |> get_number(@start, @rows)
  end

  defp col_seat(seat_information) do
    seat_information
    |> get_information(@row_len, @col_len)
    |> get_number(@start, @cols)
  end

  defp get_information(seat_information, start, len) do
    seat_information
    |> split_infomation(start, len)
    |> to_charlist()
  end

  defp get_number([], number, number), do: number

  defp get_number([h | t], lower, upper) do
    number = (lower + upper) / 2

    cond do
      h in @lower_half ->
        get_number(t, lower, trunc(number))

      h in @upper_half ->
        get_number(t, round(number), upper)
    end
  end

  defp split_infomation(seat_information, start, len) do
    String.slice(seat_information, start, len)
  end

end
