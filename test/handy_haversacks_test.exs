defmodule AdventOfCode2020.HandyHaversacksTest do
  use ExUnit.Case
  alias AdventOfCode2020.HandyHaversacks

  test "parse lines into bag map with his items" do
    input()
    |> HandyHaversacks.convert()
    |> validate_result(expected_parse())
  end

  test "extract bags who has shiny gold bags" do
    input()
    |> HandyHaversacks.convert()
    |> validate_result(expected_parse())
    |> HandyHaversacks.extract_bags_with_shiny()
    |> validate_result(expected_bags())
  end

  test "total of bags that can contain at least one shiny gold bag" do
    input()
    |> HandyHaversacks.convert()
    |> validate_result(expected_parse())
    |> HandyHaversacks.extract_bags_with_shiny()
    |> validate_result(expected_bags())
    |> HandyHaversacks.total_of_bags()
    |> validate_result(4)
  end

  defp input do
    [
      "light red bags contain 1 bright white bag, 2 muted yellow bags.",
      "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      "bright white bags contain 1 shiny gold bag.",
      "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
      "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
      "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
      "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
      "faded blue bags contain no other bags.",
      "dotted black bags contain no other bags."
    ]
  end

  defp expected_parse do
    %{
      "light red" => %{"bright white" => 1, "muted yellow" => 2},
      "dark orange" => %{"bright white" => 3, "muted yellow" => 4},
      "bright white" => %{"shiny gold" => 1},
      "muted yellow" => %{"shiny gold" => 2, "faded blue" => 9},
      "shiny gold" => %{"dark olive" => 1, "vibrant plum" => 2},
      "dark olive" => %{"faded blue" => 3, "dotted black" => 4},
      "vibrant plum" => %{"faded blue" => 5, "dotted black" => 6},
      "faded blue" => %{},
      "dotted black" => %{}
    }
  end

  defp expected_bags do
    {expected_parse(), ["bright white", "dark orange", "light red", "muted yellow"]}
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

