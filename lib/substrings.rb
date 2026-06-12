def substrings(str, dictionary)
  res = Hash.new(0)

  dictionary.each do |word|
    str.downcase.scan(word.downcase).each { res[word] += 1 }
  end

  res
end
