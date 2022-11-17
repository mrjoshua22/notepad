require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

puts 'Привет, я твой блокнот! Версия 2 + SQLite'
puts 'Что хотите записать в блокнот?'

choices = Post.post_types.keys

choice = -1

until (0...choices.size).include?(choice)
  choices.each_with_index { |type, index| puts "\t#{index}. #{type}" }

  choice = $stdin.gets.to_i
end

entry = Post.create(choices[choice])

entry.read_from_console

id = entry.save_to_db

puts "Ура, запись сохранена, id = #{id}"
