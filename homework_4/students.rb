FILE_PATH = "students.txt"
RESULTS_PATH = "results.txt"

def lineProcessing(string)
  age = ""
  string.reverse.each_char do |c|
    break if c == " "
    age += c
  end
  age.reverse!
  string.slice!(" #{age}")
  return { :name => string,
           :age => age.to_i }
end

File.delete(RESULTS_PATH) if File.exists?(RESULTS_PATH)
students = []
File.foreach(FILE_PATH) {|line| students.push(lineProcessing(line.chomp))}

loop do
  puts "Введите возраст студента или -1 для завершения:"
  age = gets.chomp.to_i
  break if age == -1
  buffer = []
  students.each do |student|
    if student[:age] == age
      File.write(RESULTS_PATH, "#{student[:name]} #{student[:age]}\n", mode: "a")
      buffer.push(student)
    end
  end
  students -= buffer
  break if students == []
end

File.foreach(RESULTS_PATH) {|line| puts line}
