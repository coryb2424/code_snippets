MORSE_CODE_ENCODE_MAP = {
  'a' => '.-',
  'b' => '-...',
  'c' => '-.-.',
  'd' => '-..',
  'e' => '.',
  'f' => '..-.',
  'g' => '--.',
  'h' => '....',
  'i' => '..',
  'j' => '.---',
  'k' => '-.-',
  'l' => '.-..',
  'm' => '--',
  'n' => '-.',
  'o' => '---',
  'p' => '.--.',
  'q' => '--.-',
  'r' => '.-.',
  's' => '...',
  't' => '-',
  'u' => '..-',
  'v' => '...-',
  'w' => '.--',
  'x' => '-..-',
  'y' => '-.--',
  'z' => '--..'
}

def encode(text)
  encoded_text = ""
  word_array = clean_text(text).split
  word_array.each_with_index do |word, word_index|
    letter_array = word.split('')
    letter_array.each_with_index do |letter, letter_index|
      encoded_text << MORSE_CODE_ENCODE_MAP[letter]
      encoded_text << ' ' unless letter_index == letter_array.length - 1
    end
    encoded_text << '|' unless word_index == word_array.length - 1
  end
  return encoded_text
end

def clean_text(dirty_text)
  dirty_text.strip.downcase.delete(',').delete('\'')
end
