defmodule AdventOfCode2021.TobogganTrajectoryTest do
  use ExUnit.Case
  alias AdventOfCode2021.TobogganTrajectory

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
      [{1, 3}, {2, 6}, {3, 9}, {4, 12}, {5, 15}, {6, 18}, {7, 21}, {8, 24}, {9, 27}, {10, 30}, {11, 33}],
      grid()
    }
  end

  defp expected_results_with_elements do
    {
      [?., ?#, ?., ?#, ?#, ?., ?#, ?#, ?#, ?#, ?.],
      [{1, 3}, {2, 6}, {3, 9}, {4, 12}, {5, 15}, {6, 18}, {7, 21}, {8, 24}, {9, 27}, {10, 30}, {11, 33}],
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

