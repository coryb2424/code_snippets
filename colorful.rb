# Takes a number as argument and return true if the number is colorful
# A colorful number is a number where all the products of consecutive subsets of
# digit are different.
# Example:
#  263 is a colorful number because (2, 6, 3, 2x6, 6x3, 2x6x3) are all different
#  236 is not because (2, 3, 6, 2x3, 3x6, 2x3x6) have 6 twice

def colorful?(number)
  if number.class == Integer
    colorful_check = []
    individual_digits = number.digits.reverse
    colorful_check << individual_digits
    colorful_check << advancing_mult(individual_digits) if individual_digits.size > 1
    colorful_check << full_mult(individual_digits) if individual_digits.size > 2
    return colorful_check.flatten.size == colorful_check.flatten.uniq.size
  end
  false
end

def advancing_mult(digits_array)
  range_limit = digits_array.size
  (0...range_limit).map do |index|
    next if index == (range_limit - 1)
    digits_array[index] * digits_array[index + 1]
  end
end

def full_mult(digits_array)
  digits_array.reduce(1) { |sum, digit| sum * digit }
end
