def foobar(n1, n2)
  if n1 == 20 || n2 == 20
    n2
  else
    n1 + n2
  end
end

puts "Введите первое число:"
n1 = gets.chomp.to_i
puts "Введите второе число:"
n2 = gets.chomp.to_i
puts "Результат: #{foobar(n1, n2)}"
