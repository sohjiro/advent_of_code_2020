defmodule AdventOfCode2020 do
  @moduledoc """
  Documentation for `AdventOfCode2020`.
  """
  @resources "lib/resources"
  @available_process ~w[process process_two]a

  def run_day(day, part) when part in @available_process do
    string_day = into_string(day)
    {module, opts} = solution_for(string_day)
    input = input_data_for(string_day, opts)

    apply(module, part, [input])
  end

  defp into_string(day) do
    day
    |> to_string()
    |> String.pad_leading(2, "0")
  end

  defp solution_for(string_day) do
    Map.get(avaliable_solutions(), string_day)
  end

  defp input_data_for(string_day, opts) do
    string_day
    |> resources()
    |> read_file()
    |> parse(opts)
  end

  defp resources(day_number) do
    day_number
    |> generate_file_name()
    |> generate_file_path()
  end

  defp generate_file_name(day_number) do
    "day_" <> day_number <> "_input.txt"
  end

  defp generate_file_path(name) do
    Path.join(@resources, name)
  end

  defp read_file(input_path) do
    File.read!(input_path)
  end

  defp parse(text, opts) do
    String.split(text, "\n", opts)
  end

  defp avaliable_solutions do
    %{
      "01" => {AdventOfCode2020.ReportRepair, trim: true},
      "02" => {AdventOfCode2020.PasswordPhilosofy, trim: true},
      "03" => {AdventOfCode2020.TobogganTrajectory, trim: true},
      "04" => {AdventOfCode2020.PassportProcessing, []},
      "05" => {AdventOfCode2020.BinaryBoarding, trim: true},
      "06" => {AdventOfCode2020.CustomCustoms, []},
      "07" => {AdventOfCode2020.HandyHaversacks, trim: true},
      "08" => {AdventOfCode2020.HandheldHalting, trim: true},
      "09" => {AdventOfCode2020.EncodingError, trim: true}
    }
  end

end
