defmodule AdventOfCode2021.PassportProcessingTest do
  use ExUnit.Case
  alias AdventOfCode2021.PassportProcessing

  test "group passports information" do
    input()
    |> PassportProcessing.collect_passport_information()
    |> validate_result(expected_passports())
  end

  test "convert to passports" do
    input()
    |> PassportProcessing.collect_passport_information()
    |> validate_result(expected_passports())
    |> PassportProcessing.generate_passport()
    |> validate_result(expected_map_information())
  end

  test "valid passports information" do
    input()
    |> PassportProcessing.collect_passport_information()
    |> validate_result(expected_passports())
    |> PassportProcessing.generate_passport()
    |> validate_result(expected_map_information())
    |> PassportProcessing.verify_passport_information()
    |> validate_result(expected_verification())
    |> PassportProcessing.count_valid_passports()
    |> validate_result(2)
  end

  defp input do
    [
      "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
      "byr:1937 iyr:2017 cid:147 hgt:183cm",
      "",
      "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
      "hcl:#cfa07d byr:1929",
      "",
      "hcl:#ae17e1 iyr:2013",
      "eyr:2024",
      "ecl:brn pid:760753108 byr:1931",
      "hgt:179cm",
      "",
      "hcl:#cfa07d eyr:2025 pid:166559648",
      "iyr:2011 ecl:brn hgt:59in"
    ]
  end

  defp expected_passports do
    [
      "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm",
      "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
      "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
      "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in"
    ]
  end

  defp expected_map_information do
    [
      %{"ecl" => "gry", "pid" => "860033327", "eyr" => "2020", "hcl" => "#fffffd", "byr" => "1937", "iyr" => "2017", "cid" => "147", "hgt" => "183cm"},
      %{"iyr" => "2013", "ecl" => "amb", "cid" => "350", "eyr" => "2023", "pid" => "028048884", "hcl" => "#cfa07d", "byr" => "1929"},
      %{"hcl" => "#ae17e1", "iyr" => "2013", "eyr" => "2024", "ecl" => "brn", "pid" => "760753108", "byr" => "1931", "hgt" => "179cm"},
      %{"hcl" => "#cfa07d", "eyr" => "2025", "pid" => "166559648", "iyr" => "2011", "ecl" => "brn", "hgt" => "59in"}
    ]
  end

  defp expected_verification do
    [
      {true, %{"ecl" => "gry", "pid" => "860033327", "eyr" => "2020", "hcl" => "#fffffd", "byr" => "1937", "iyr" => "2017", "cid" => "147", "hgt" => "183cm"}},
      {false, %{"iyr" => "2013", "ecl" => "amb", "cid" => "350", "eyr" => "2023", "pid" => "028048884", "hcl" => "#cfa07d", "byr" => "1929"}},
      {true, %{"hcl" => "#ae17e1", "iyr" => "2013", "eyr" => "2024", "ecl" => "brn", "pid" => "760753108", "byr" => "1931", "hgt" => "179cm"}},
      {false, %{"hcl" => "#cfa07d", "eyr" => "2025", "pid" => "166559648", "iyr" => "2011", "ecl" => "brn", "hgt" => "59in"}}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

