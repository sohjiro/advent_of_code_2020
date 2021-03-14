defmodule AdventOfCode2021.TobogganTrajectory do

  def process(text) do
    text
    |> prepare_coordinates()
    |> fetch_elements()
    |> total_of_trees()
  end

  def prepare_coordinates(input, right \\ 3, down \\ 1) do
    grid = Stream.map(input, &to_stream/1)

    coordinates =
      grid
      |> Stream.with_index()
      |> Stream.map(&calculate_coordinate(&1, right, down))
      |> Enum.to_list()

    {coordinates, Enum.to_list(grid)}
  end

  defp calculate_coordinate({_fun_data, index}, right, down) do
    row = index + down
    {row, row * right}
  end

  def fetch_elements({coordinates, grid}) do
    results =
      coordinates
      |> Stream.map(&get_element_from_grid(&1, grid))
      |> Enum.to_list()

    {results, coordinates, grid}
  end

  def total_of_trees({recollection, _coord, _grid}) do
    recollection
    |> Enum.filter(&(&1 === ?#))
    |> Enum.count()
  end

  defp get_element_from_grid({row, col}, grid) do
    grid
    |> Enum.at(row, Stream.cycle('.'))
    |> Enum.at(col)
  end

  defp to_stream(row) do
    row
    |> to_charlist()
    |> Stream.cycle()
  end


end
