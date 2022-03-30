require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

require 'optparse'

options = {}

# Заведем нужные нам опции
OptionParser.new do |opt|
  # Этот текст будет выводиться, когда программа запущена с опцией -h
  opt.banner = 'Usage: read.rb [options]'

  # Вывод в случае, если запросили help
  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  # Опция --type будет передавать тип поста, который мы хотим считать
  opt.on('--type POST_TYPE', 'какой тип постов показывать ' \
         '(по умолчанию любой)') { |o| options[:type] = o }

  # Опция --id передает номер записи в базе данных (идентификатор)
  opt.on('--id POST_ID', 'если задан id — показываем подробно ' \
         ' только этот пост') { |o| options[:id] = o }

  # Опция --limit передает, сколько записей мы хотим прочитать из базы
  opt.on('--limit NUMBER', 'сколько последних постов показать ' \
         '(по умолчанию все)') { |o| options[:limit] = o }

end.parse!

result = Post.find(options[:limit], options[:type], options[:id])

if result.is_a? Post
  puts "Запись #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each { |line| puts line }
else

  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  result&.each do |row|
    puts

    row.each do |element|
      element_text = "| #{element.to_s.delete("\n")[0..17]}"

      element_text << ' ' * (21 - element_text.size)

      print element_text
    end

    print '|'
  end

  puts
end
