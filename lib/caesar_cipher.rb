def caesar_cipher(str, shift)
  alphabet = ("a".."z").to_a
  res = ""
  str.each_char do |char|
    if alphabet.include?(char.downcase)
      new_index = (alphabet.index(char.downcase) + shift) % 26
      shifted = alphabet[new_index]
      res += char == char.upcase ? shifted.upcase : shifted
    else
      res += char
    end
  end
  res
end
