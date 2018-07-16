MORSE_CODE_DECODE_MAP = {
  '.-'    => 'A',
  '-...'  => 'B',
  '-.-.'  => 'C',
  '-..'   => 'D',
  '.'     => 'E',
  '..-.'  => 'F',
  '--.'   => 'G',
  '....'  => 'H',
  '..'    => 'I',
  '.---'  => 'J',
  '-.-'   => 'K',
  '.-..'  => 'L',
  '--'    => 'M',
  '-.'    => 'N',
  '---'   => 'O',
  '.--.'  => 'P',
  '--.-'  => 'Q',
  '.-.'   => 'R',
  '...'   => 'S',
  '-'     => 'T',
  '..-'   => 'U',
  '...-'  => 'V',
  '.--'   => 'W',
  '-..-'  => 'X',
  '-.--'  => 'Y',
  '--..'  => 'Z'
}


def decode(morse_text)
  decoded_text = ""
  encoded_word_array = morse_text.split('|')
  encoded_word_array.each_with_index do |encoded_word, index|
    encode_letter_array = encoded_word.split(' ')
    encode_letter_array.each do |encoded_letter|
      decoded_text << MORSE_CODE_DECODE_MAP[encoded_letter]
    end
    decoded_text << " " unless index == encoded_word_array.length - 1
  end
  return decoded_text
end
