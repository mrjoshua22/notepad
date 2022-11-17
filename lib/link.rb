class Link < Post
  def initialize
    super

    @url = ''
  end

  def load_data(data_hash)
    super

    @text = data_hash['text']
    @url = data_hash['url']
  end

  def read_from_console
    puts 'Адрес ссылки:'
    @url = $stdin.gets.chomp

    puts 'Что за ссылка?'
    @text = $stdin.gets.chomp
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%d.%m.%Y, %H.%M.%S')}\n\n"
    
    [time_string, @url, @text]
  end
end
