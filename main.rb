# frozen_string_literal: true

require_relative 'database'

# book
class Book
  def initialize(database)
    @db = Message.new database
  end

  def add(author, text)
    @db.create(author, text)
    puts 'Message saved'
  end

  def remove(id)
    @db.delete(id)
    puts 'Deleted'
  end

  def show
    puts '--- Messages ---'
    @db.all.each do |message|
      puts "##{message['id']} | #{message['author']} [#{message['created_at']}]"
      puts message['text']
    end
  end
end

def main_put
  puts '1. Show all'
  puts '2. Add message'
  puts '3. Delete message'
  printf "4. Exit\n\n"
  printf 'Choose: '
end

if __FILE__ == $PROGRAM_NAME
  book = Book.new 'guestbook'
  loop do
    main_put
    case readline.chomp
    when '1'
      book.show
    when '2'
      printf 'Author: '
      author = readline.chomp
      printf 'Text: '
      book.add author, readline.chomp
    when '3'
      printf 'Enter message number: '
      book.remove(readline.to_i)
    when '4'
      puts 'Exit'
      break
    else
      puts 'Invalid command'
    end
    puts
  end
end
