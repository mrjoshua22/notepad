class Post
  def initialize
    @created_at = Time.now
    @text = nil
  end

  def file_path
    file_name = @created_at.strftime("#{self.class}_%d-%m-%Y_%H-%M-%S.txt")
    "#{__dir__}/#{file_name}"
  end

  def read_from_console
    # todo
  end

  def save
    File.open(file_path, 'w:UTF-8') do |file|
      to_strings.each { |string| file.puts(string) }
    end
  end

  def to_strings
    # todo
  end
end
