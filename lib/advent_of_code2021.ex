defmodule AdventOfCode2021 do
  @moduledoc """
  Documentation for `AdventOfCode2021`.
  """

  def run_day_six_one(input_path) do
    input_path
    |> read_file()
    |> parse()
    |> AdventOfCode2021.CustomCustomsOne.process()
  end

  defp read_file(input_path) do
    File.read!(input_path)
  end

  def parse(text) do
    String.split(text, "\n")
  end

end
