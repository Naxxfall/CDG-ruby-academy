def pokemonCreate(pokemonName, pokemonColor)
  pokemon = {:name => pokemonName, :color => pokemonColor}
  return pokemon
end

def pokemonShow(pokemon)
  return "Покемона зовут #{pokemon[:name]}. Его цвет: #{pokemon[:color]}"
end

puts "Введите количество покемонов:"
size = gets.chomp.to_i
pokeball = []
size.times do
  puts "Введите имя покемона:"
  name = gets.chomp.to_str
  puts "Введите цвет покемона:"
  color = gets.chomp.to_str
  pokeball.push(pokemonCreate(name, color))
end

puts pokeball

pokeball.each_with_index do |pokemon, index|
  puts "Характеристики покемона #{index + 1}:"
  puts pokemonShow(pokemon)
end