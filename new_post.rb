require_relative 'lib/post'
require_relative 'lib/link'
require_relative 'lib/memo'
require_relative 'lib/task'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокнот?'

types = Post.post_types.keys

choice = -1

until choice >= 0 && choice < types.size
  types.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  choice = $stdin.gets.chomp.to_i
end

entry = Post.create(types[choice])

entry.read_from_console

id = entry.save_to_db

puts "Запись сохранена! id = #{id}"
