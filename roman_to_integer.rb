ROMAN_VALUES = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}

def roman_to_integer(roman_string)
  return ROMAN_VALUES[roman_string] if roman_string.chars.size == 1
  roman_string.chars.each_cons(2).reduce(0) do |sum, (first, second)|
    sum + ((ROMAN_VALUES[first] >= ROMAN_VALUES[second] ? 1 : -1) * ROMAN_VALUES[first])
  end + ROMAN_VALUES[roman_string.chars.last]
end
