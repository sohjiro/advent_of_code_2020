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

  test "valid passports information for second part" do
    extended_input()
    |> PassportProcessing.collect_passport_information()
    |> validate_result(expected_extended_passports())
    |> PassportProcessing.generate_passport()
    |> validate_result(expected_map_information_extended())
    |> PassportProcessing.verify_passport_information_extended()
    |> validate_result(expected_verification_extended())
    |> PassportProcessing.count_valid_passports()
    |> validate_result(4)
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

  defp extended_input do
    [
      "eyr:1972 cid:100",
      "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
      "",
      "iyr:2019",
      "hcl:#602927 eyr:1967 hgt:170cm",
      "ecl:grn pid:012533040 byr:1946",
      "",
      "hcl:dab227 iyr:2012",
      "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
      "",
      "hgt:59cm ecl:zzz",
      "eyr:2038 hcl:74454a iyr:2023",
      "pid:3556412378 byr:2007",
      "",
      "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980",
      "hcl:#623a2f",
      "",
      "eyr:2029 ecl:blu cid:129 byr:1989",
      "iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm",
      "",
      "hcl:#888785",
      "hgt:164cm byr:2001 iyr:2015 cid:88",
      "pid:545766238 ecl:hzl",
      "eyr:2022",
      "",
      "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719",
    ]
  end

  defp expected_extended_passports do
    [
      "eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
      "iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946",
      "hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
      "hgt:59cm ecl:zzz eyr:2038 hcl:74454a iyr:2023 pid:3556412378 byr:2007",
      "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f",
      "eyr:2029 ecl:blu cid:129 byr:1989 iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm",
      "hcl:#888785 hgt:164cm byr:2001 iyr:2015 cid:88 pid:545766238 ecl:hzl eyr:2022",
      "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719",
    ]
  end

  defp expected_map_information_extended do
    [
      %{"byr" => "1926", "cid" => "100", "ecl" => "amb", "eyr" => "1972", "hcl" => "#18171d", "hgt" => "170", "iyr" => "2018", "pid" => "186cm"},
      %{"byr" => "1946", "ecl" => "grn", "eyr" => "1967", "hcl" => "#602927", "hgt" => "170cm", "iyr" => "2019", "pid" => "012533040"},
      %{"byr" => "1992", "cid" => "277", "ecl" => "brn", "eyr" => "2020", "hcl" => "dab227", "hgt" => "182cm", "iyr" => "2012", "pid" => "021572410"},
      %{"byr" => "2007", "ecl" => "zzz", "eyr" => "2038", "hcl" => "74454a", "hgt" => "59cm", "iyr" => "2023", "pid" => "3556412378"},
      %{"byr" => "1980", "ecl" => "grn", "eyr" => "2030", "hcl" => "#623a2f", "hgt" => "74in", "iyr" => "2012", "pid" => "087499704"},
      %{"byr" => "1989", "cid" => "129", "ecl" => "blu", "eyr" => "2029", "hcl" => "#a97842", "hgt" => "165cm", "iyr" => "2014", "pid" => "896056539"},
      %{"byr" => "2001", "cid" => "88", "ecl" => "hzl", "eyr" => "2022", "hcl" => "#888785", "hgt" => "164cm", "iyr" => "2015", "pid" => "545766238"},
      %{"byr" => "1944", "ecl" => "blu", "eyr" => "2021", "hcl" => "#b6652a", "hgt" => "158cm", "iyr" => "2010", "pid" => "093154719"}
    ]
  end

  defp expected_verification_extended do
    [
      {false, %{"byr" => "1926", "cid" => "100", "ecl" => "amb", "eyr" => "1972", "hcl" => "#18171d", "hgt" => "170", "iyr" => "2018", "pid" => "186cm"}},
      {false, %{"byr" => "1946", "ecl" => "grn", "eyr" => "1967", "hcl" => "#602927", "hgt" => "170cm", "iyr" => "2019", "pid" => "012533040"}},
      {false, %{"byr" => "1992", "cid" => "277", "ecl" => "brn", "eyr" => "2020", "hcl" => "dab227", "hgt" => "182cm", "iyr" => "2012", "pid" => "021572410"}},
      {false, %{"byr" => "2007", "ecl" => "zzz", "eyr" => "2038", "hcl" => "74454a", "hgt" => "59cm", "iyr" => "2023", "pid" => "3556412378"}},
      {true, %{"byr" => "1980", "ecl" => "grn", "eyr" => "2030", "hcl" => "#623a2f", "hgt" => "74in", "iyr" => "2012", "pid" => "087499704"}},
      {true, %{"byr" => "1989", "cid" => "129", "ecl" => "blu", "eyr" => "2029", "hcl" => "#a97842", "hgt" => "165cm", "iyr" => "2014", "pid" => "896056539"}},
      {true, %{"byr" => "2001", "cid" => "88", "ecl" => "hzl", "eyr" => "2022", "hcl" => "#888785", "hgt" => "164cm", "iyr" => "2015", "pid" => "545766238"}},
      {true, %{"byr" => "1944", "ecl" => "blu", "eyr" => "2021", "hcl" => "#b6652a", "hgt" => "158cm", "iyr" => "2010", "pid" => "093154719"}}
    ]
  end

  defp validate_result(result, expected) do
    assert expected == result
    result
  end
end

