defmodule AdventOfCode2020.HandyHaversacks do
  @line_split " bags contain "
  @bag_name "shiny gold"

  def process(text) do
    text
    |> convert()
    |> extract_bags_with_shiny()
    |> total_of_bags()
  end

  def process_two(text) do
    text
    |> convert()
    |> total_of_shiny_bags()
  end

  def convert(text) do
    text
    |> split_line()
    |> generate_map()
  end

  def extract_bags_with_shiny(bags) do
    {bags, search_bags(bags, [@bag_name], [])}
  end

  def total_of_shiny_bags(bags, bag_name \\ @bag_name) do
    nested_data(bags, bag_name)
  end

  def total_of_bags({_bags, names}), do: Enum.count(names)

  defp search_bags(_bags, [], acc), do: acc |> MapSet.new() |> MapSet.to_list()

  defp search_bags(bags, [name | t], acc) do
    names = filter_bag_names(bags, name)
    search_bags(bags, Enum.concat(names, t), Enum.concat(names, acc))
  end

  defp filter_bag_names(bags, name) do
    bags
    |> Enum.filter(&contains_bag_name?(&1, name))
    |> Enum.map(fn({k, _v}) -> k end)
  end

  defp contains_bag_name?({_k, v}, name), do: v |> Map.keys() |> Enum.any?(&(&1 === name))

  defp split_line(text) do
    Enum.map(text, &break_down(&1, @line_split))
  end

  defp generate_map(list) do
    list
    |> Enum.map(&extract_bags/1)
    |> Enum.into(%{})
  end

  defp extract_bags([container, items]) do
    {container, extract_items(items)}
  end

  defp extract_items(items) do
    items
    |> String.replace(~r/(bags)|(bag)|\./, "")
    |> break_down(",", trim: true)
    |> item_into_map()
  end

  defp item_into_map(["no other "]), do: %{}

  defp item_into_map(items) do
    Enum.into(items, %{}, &parse/1)
  end

  defp parse("no other "), do: {}
  defp parse(item) do
    {qty, bag} =
      item
      |> String.trim()
      |> Integer.parse()

    {String.trim(bag), qty}
  end

  defp break_down(string, pattern, opts \\ []) do
    String.split(string, pattern, opts)
  end

  defp nested_data(bags, bag_name) do
    bags
    |> Map.get(bag_name)
    |> reduce_nodes(bags)
  end

  defp reduce_nodes(nodes, bags) do
    Enum.reduce(nodes, 0, fn({name, qty}, acc) ->
      (qty + qty * nested_data(bags, name)) + acc
    end)
  end

end
