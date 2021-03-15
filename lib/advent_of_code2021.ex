defmodule AdventOfCode2021 do
  @moduledoc """
  Documentation for `AdventOfCode2021`.
  """
  @resources "lib/resources"

  def run_day_one_one(input_path \\ "day_01_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2021.ReportRepair.process()
  end

  def run_day_two_one(input_path \\ "day_02_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2021.PasswordPhilosofy.process()
  end

  def run_day_three_one(input_path \\ "day_03_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2021.TobogganTrajectory.process()
  end

  def run_day_four_one(input_path \\ "day_04_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2021.PassportProcessing.process()
  end

  def run_day_five_one(input_path \\ "day_05_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2021.BinaryBoarding.process()
  end

  def run_day_six_one(input_path \\ "day_06_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2021.CustomCustomsOne.process()
  end

  defp read_file(input_path) do
    File.read!(input_path)
  end

  def parse(text, opts \\ []) do
    String.split(text, "\n", opts)
  end

end
