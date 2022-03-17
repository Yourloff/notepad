require_relative 'lib/post'
require_relative 'lib/link'
require_relative 'lib/memo'
require_relative 'lib/task'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокнот?'

types = Post.post_types

choice = -1

until choice >= 0 && choice < types.size
  types.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save

puts 'Запись сохранена!'
