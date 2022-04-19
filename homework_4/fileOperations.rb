def index(file)
  File.foreach(file) {|line| puts line}
end

def find(file, id)
  File.foreach(file).with_index do |line, index|
    if index == id
      puts line
      return
    end
  end
end

def where(file, pattern)
  File.foreach(file) do |line|
    puts(line) if line.include?(pattern)
  end
end

def update(file, id, text)
  buffer = File.open("buffer.txt", 'w')
  File.foreach(file).with_index do |line, index|
    if index != id
      buffer.puts(line)
    else
      buffer.puts(text)
    end
  end
  buffer.close
  File.write(file, File.read(buffer))
  File.delete("buffer.txt") if File.exists?("buffer.txt")
end

def delete(file, id)
  buffer = File.open("buffer.txt", 'w')
  File.foreach(file).with_index do |line, index|
    buffer.puts(line) if index != id
  end
  buffer.close
  File.write(file, File.read(buffer))
  File.delete("buffer.txt") if File.exists?("buffer.txt")
end
