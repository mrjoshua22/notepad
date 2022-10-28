require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокнот?'

path_to_save = "#{__dir__}/data/"

choices = Post.post_types

choice = -1

until (0...choices.size).include?(choice)
  choices.each_with_index { |type, index| puts "\t#{index}. #{type}" }

  choice = $stdin.gets.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save(path_to_save)

puts 'Ура, запись сохранена!'
