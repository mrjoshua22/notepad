require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts 'Что надо сделать?'
    @text = $stdin.gets.chomp

    puts 'К какому числу? Укажите дату в формате ДД.ММ.ГГГГ, например, 12.03.2020'
    date = $stdin.gets.chomp

    @due_date = Date.parse(date)
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%d.%m.%Y, %H.%M.%S')}\n\n"

    deadline = "Крайний срок: #{@due_date}"
    
    [time_string, @text, deadline]
  end
end
