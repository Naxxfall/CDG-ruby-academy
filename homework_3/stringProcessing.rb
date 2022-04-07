def stringProcessing(word)
  if word[-2] + word[-1] == "CS"
    return 2 ** word.length
  else
    return word.reverse
  end
end

puts "Введите слово:"
word = gets.chomp
puts stringProcessing(word)