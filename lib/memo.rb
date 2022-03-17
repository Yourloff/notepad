class Memo < Post
  def read_from_console
    puts 'Новая заметка:'

    @text = []
    line = nil

    while line != 'end' do
      line = STDIN.gets.chomp
      @text << line
    end
    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H.%M.%S')}\r\r"

    @text.unshift(time_string)
  end
end
