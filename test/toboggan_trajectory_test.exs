defmodule AdventOfCode2020.TobogganTrajectoryTest do
  use ExUnit.Case
  alias AdventOfCode2020.TobogganTrajectory

  test "should calculate the coordinates for a given input" do
    basic_input()
    |> TobogganTrajectory.prepare_coordinates()
    |> validate_result(expected_coordinates())
  end

  test "should get all the elements at the given position" do
    basic_input()
    |> TobogganTrajectory.prepare_coordinates()
    |> validate_result(expected_coordinates())
    |> TobogganTrajectory.fetch_elements()
    |> validate_result(expected_results_with_elements())
  end

  test "should count all the trees that were recollected" do
    basic_input()
    |> TobogganTrajectory.prepare_coordinates()
    |> validate_result(expected_coordinates())
    |> TobogganTrajectory.fetch_elements()
    |> validate_result(expected_results_with_elements())
    |> TobogganTrajectory.total_of_trees()
    |> validate_result(7)
  end

  test "prepare coordinates for steps larger that one" do
    basic_input()
    |> TobogganTrajectory.prepare_coordinates(1, 2)
    |> validate_result(expected_large_coordinates())
  end

  test "should count all the trees that were recollected for second part" do
    coordinates = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    basic_input()
    |> TobogganTrajectory.process_multiple_coordinates(coordinates)
    |> validate_result([2, 7, 3, 4, 2])
    |> TobogganTrajectory.total_of_trees_for_multiple()
    |> validate_result(336)
  end

  defp basic_input do
    [
      "..##.........##.........##.........##.........##.........##.......",
      "#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..",
      ".#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.",
      "..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#",
      ".#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.",
      "..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....",
      ".#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#",
      ".#........#.#........#.#........#.#........#.#........#.#........#",
      "#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...",
      "#...##....##...##....##...##....##...##....##...##....##...##....#",
      ".#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"
    ]
  end

  defp expected_coordinates do
    {
      [{3, 1}, {6, 2}, {9, 3}, {12, 4}, {15, 5}, {18, 6}, {21, 7}, {24, 8}, {27, 9}, {30, 10}, {33, 11}],
      grid()
    }
  end

  defp expected_large_coordinates do
    {
      [{1, 2}, {2, 4}, {3, 6}, {4, 8}, {5, 10}, {6, 12}, {7, 14}, {8, 16}, {9, 18}, {10, 20}, {11, 22}],
      grid()
    }
  end

  defp expected_results_with_elements do
    {
      [?., ?#, ?., ?#, ?#, ?., ?#, ?#, ?#, ?#, ?.],
      [{3, 1}, {6, 2}, {9, 3}, {12, 4}, {15, 5}, {18, 6}, {21, 7}, {24, 8}, {27, 9}, {30, 10}, {33, 11}],
      grid()
    }
  end

  defp grid do
    [
      Stream.cycle('..##.........##.........##.........##.........##.........##.......'),
      Stream.cycle('#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..'),
      Stream.cycle('.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.'),
      Stream.cycle('..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#'),
      Stream.cycle('.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.'),
      Stream.cycle('..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....'),
      Stream.cycle('.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#'),
      Stream.cycle('.#........#.#........#.#........#.#........#.#........#.#........#'),
      Stream.cycle('#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...'),
      Stream.cycle('#...##....##...##....##...##....##...##....##...##....##...##....#'),
      Stream.cycle('.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#'),
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

