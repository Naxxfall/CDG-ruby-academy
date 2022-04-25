DEFAULT_BALANCE = 100.0
BALANCE_FILE_PATH = "balance.txt"

class CashMachine
  attr_reader :current_balance
  def initialize(balance_data)
    @current_balance = balance_data
  end

  def init
    puts "Добро пожаловать на Ваш банковский счет!"
    loop do
      show_tips
      command = gets.chomp.upcase
      case command
      when "B"
        self.show_balance
      when "D"
        self.deposite
      when "W"
        self.withdraw
      when "Q"
        puts "Ваши финансы очень важны для нас. До свидания!"
        return
      else
        show_error("Введена неправильная команда!")
      end
    end
  end

  def show_tips
    puts 'Команда "D" для зачисления средств на счет'
    puts 'Команда "W" для вывода средств'
    puts 'Команда "B" для отображения баланса'
    puts 'Команда "Q" для выхода'
    puts "Введите команду:"
  end

  def show_error(message)
    puts "Ошибка! #{message}"
  end

  def show_balance
    puts "Ваш текущий баланс: #{@current_balance}"
  end

  def deposite
    puts 'Введите сумму, которую хотите внести на Ваш счет, либо "Q" для отмены операции. Сумма должна быть больше 0:'
    input = gets.chomp
    return if input.upcase == "Q"
    money = input.to_f
    if money > 0.0
      @current_balance += money
      self.show_balance
    else
      show_error("Для занесения на счет укажите положительное число!")
      self.deposite
    end
  end

  def withdraw
    puts 'Введите сумму, которую хотите снять с Вашего счета, либо "Q" для отмены операции.
Сумма должна быть больше 0 и не превышать вашего текущего баланса:'
    input = gets.chomp
    return if input.upcase == "Q"
    money = input.to_f
    case
    when money > 0.0 && money <= @current_balance
      @current_balance -= money
      self.show_balance
    when money > @current_balance
      show_error("Запрошенная сумма превышает Ваш текущий баланс!")
      self.withdraw
    else
      show_error("Для снятия средств укажите положительное число!")
      self.withdraw
    end
  end
end

File.exists?(BALANCE_FILE_PATH) ? current_balance = File.read(BALANCE_FILE_PATH).chomp.to_f : current_balance = DEFAULT_BALANCE

my_balance = CashMachine.new(current_balance)
my_balance.init

File.write(BALANCE_FILE_PATH, my_balance.current_balance)