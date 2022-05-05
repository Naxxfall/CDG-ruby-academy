require 'socket'
require 'cgi'

$server = TCPServer.new("0.0.0.0", 8000)

DEFAULT_BALANCE = 100.0
BALANCE_FILE_PATH = "balance.txt"

class CashMachine
  attr_reader :current_balance
  def initialize(balance_data)
    @current_balance = balance_data
  end

  def init
    while connection = $server.accept
      request = connection.gets
      method, path = request.split(' ')
      params = CGI::parse(path || "")
      pp params
      command = params.keys.first.split("?").first
      pp command
      value = params.values.first.first.to_i
      pp value
      case command
      when "/"
        self.send_head(connection)
        connection.print('Добро пожаловать на ваш счет')
        connection.print('<p><a href=/balance>Ваш текущий баланс</a></p>')
        connection.print('<p>Для внесения средств введите /deposite?value=сумма</p>')
        connection.print('<p>Для снятия средств средств введите /withdraw?value=сумма</p>')
      when "/balance"
        self.show_balance(connection)
      when "/deposite"
        self.deposite(connection, value)
      when "/withdraw"
        self.withdraw(connection, value)
      else
        show_error(connection, "Введена неправильная команда!")
      end
      File.write(BALANCE_FILE_PATH, @current_balance)
    end
    connection.close
  end

  def send_head(connection)
    connection.print "HTTP/1.1 200\r\n"
    connection.print "Content-Type: text/html; charset=UTF-8\r\n"
    connection.print "\r\n"
  end

  def show_error(connection, message)
    connection.print "HTTP/1.1 400\r\n"
    connection.print "Content-Type: text/html; charset=UTF-8\r\n"
    connection.print "\r\n"
    connection.print "<p>Ошибка! #{message}</p>"
    connection.print('<p><a href=../>На Главную</a></p>')
  end

  def show_balance(connection)
    send_head(connection)
    connection.print "<p>Ваш текущий баланс: #{@current_balance}</p>"
    connection.print('<p><a href=../>На Главную</a></p>')
  end

  def deposite(connection, value)
    if value > 0.0
      @current_balance += value
      send_head(connection)
      connection.print("Внесено на счет #{value}")
      connection.print('<p><a href=../>На Главную</a></p>')
    else
      show_error(connection, "Для занесения на счет укажите положительное число!")
    end
  end

  def withdraw(connection, value)

    case
    when value > 0.0 && value <= @current_balance
      @current_balance -= value
      send_head(connection)
      connection.print("Снято со счета #{value}")
      connection.print('<p><a href=../>На Главную</a></p>')
    when value > @current_balance
      show_error(connection, "Запрошенная сумма превышает Ваш текущий баланс!")
    else
      show_error(connection, "Для снятия средств укажите положительное число!")
    end
  end
end

File.exists?(BALANCE_FILE_PATH) ? current_balance = File.read(BALANCE_FILE_PATH).chomp.to_f : current_balance = DEFAULT_BALANCE

my_balance = CashMachine.new(current_balance)
my_balance.init
