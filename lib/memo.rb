class Memo < Post
  def read_from_console
    puts 'Новая заметка (все, что пишете до строчки "end")'

    line = nil

    until line == 'end'
      line = $stdin.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%d.%m.%Y, %H.%M.%S')}\n\n"
    
    @text.unshift(time_string)
  end
end
