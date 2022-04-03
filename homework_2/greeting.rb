def greeting(name, sname, age)
  if age < 18
    puts "Привет, #{name} #{sname}! Тебе меньше 18 лет, но начать учиться программировать никогда не рано!"
  else
    puts "Привет, #{name} #{sname}! Самое время заняться делом!"
  end
end

puts "Введите ваше имя:"
name = gets.chomp.to_s.capitalize
puts "Введите вашу фамилию:"
sname = gets.chomp.to_s.capitalize
puts "Введите ваш возраст:"
age = gets.chomp.to_i
greeting(name, sname, age)