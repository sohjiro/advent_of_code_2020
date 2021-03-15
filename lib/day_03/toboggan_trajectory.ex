defmodule AdventOfCode2020.TobogganTrajectory do
  @default_coordinates [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

  def process(text) do
    text
    |> prepare_coordinates()
    |> fetch_elements()
    |> total_of_trees()
  end

  def process_two(text, coordinates \\ @default_coordinates) do
    text
    |> process_multiple_coordinates(coordinates)
    |> total_of_trees_for_multiple()
  end

  def process_multiple_coordinates(input, coordinates) do
    coordinates
    |> Enum.map(fn({right, down}) ->
      input
      |> prepare_coordinates(right, down)
      |> fetch_elements()
      |> total_of_trees()
    end)
  end

  def total_of_trees_for_multiple(trees) do
    Enum.reduce(trees, fn(tree, acc) -> tree * acc end)
  end

  def prepare_coordinates(input, right \\ 3, down \\ 1) do
    grid = Stream.map(input, &to_stream/1)

    coordinates =
      grid
      |> Enum.reduce([{0, 0}], &calculate_coordinate(&1, &2, right, down))
      |> Enum.reverse()
      |> tl()

    {coordinates, Enum.to_list(grid)}
  end

  defp calculate_coordinate(_fun_data, [{x, y} | _t] = acc, right, down) do
    [{x + right, y + down} | acc]
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

  defp get_element_from_grid({col, row}, grid) do
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
