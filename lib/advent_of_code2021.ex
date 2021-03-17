defmodule AdventOfCode2020 do
  @moduledoc """
  Documentation for `AdventOfCode2020`.
  """
  @resources "lib/resources"

  def run_day_one_one(input_path \\ "day_01_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.ReportRepair.process()
  end

  def run_day_one_two(input_path \\ "day_01_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.ReportRepair.process_two()
  end

  def run_day_two_one(input_path \\ "day_02_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.PasswordPhilosofy.process()
  end

  def run_day_two_two(input_path \\ "day_02_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.PasswordPhilosofy.process_two()
  end

  def run_day_three_one(input_path \\ "day_03_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.TobogganTrajectory.process()
  end

  def run_day_three_two(input_path \\ "day_03_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.TobogganTrajectory.process_two()
  end

  def run_day_four_one(input_path \\ "day_04_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2020.PassportProcessing.process()
  end

  def run_day_four_two(input_path \\ "day_04_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2020.PassportProcessing.process_two()
  end

  def run_day_five_one(input_path \\ "day_05_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.BinaryBoarding.process()
  end

  def run_day_five_two(input_path \\ "day_05_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.BinaryBoarding.process_two()
  end

  def run_day_six_one(input_path \\ "day_06_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2020.CustomCustoms.process()
  end

  def run_day_six_two(input_path \\ "day_06_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse()
    |> AdventOfCode2020.CustomCustoms.process_two()
  end

  def run_day_seven_one(input_path \\ "day_07_input.txt") do
    @resources
    |> Path.join(input_path)
    |> read_file()
    |> parse(trim: true)
    |> AdventOfCode2020.HandyHaversacks.process()
  end

  defp read_file(input_path) do
    File.read!(input_path)
  end

  def parse(text, opts \\ []) do
    String.split(text, "\n", opts)
  end

end
