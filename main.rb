# frozen_string_literal: true

require_relative 'database'

# book
class Book
  class << self
    def add(author, text)
      message = Message.create(author:, text:)
      if message.persisted?
        puts 'Message saved'
      else
        puts "Error #{message.errors.full_messages.join(', ')}"
      end
    end

    def remove(id)
      message = Message.find_by(id:)
      if message
        message.destroy
        puts 'Deleted'
      else
        puts "No message with #{id}"
      end
    end

    def search(keyword)
      messages = Message.where('author LIKE ? OR text LIKE ?', "%#{keyword}%", "%#{keyword}%")
      if messages.empty?
        puts 'Not Found'
      else
        messages.each do |message|
          show(message)
        end
      end
    end

    def show(message = nil)
      if message
        puts "##{message.id} | #{message.author} [#{message.created_at}]"
        puts message.text
      else
        Message.all.each do |msg|
          show(msg)
        end
      end
    end
  end
end

def main_put
  puts '1. Show all'
  puts '2. Add message'
  puts '3. Delete message'
  puts '4. Search message'
  printf "5. Exit\n\n"
  printf 'Choose: '
end

if __FILE__ == $PROGRAM_NAME
  loop do
    main_put
    case readline.chomp
    when '1'
      puts '--- Messages ---'
      Book.show
    when '2'
      printf 'Author: '
      author = readline.chomp
      printf 'Text: '
      Book.add author, readline.chomp
    when '3'
      printf 'Enter message number: '
      Book.remove(readline.to_i)
    when '4'
      printf 'Enter keyword: '
      Book.search(readline.chomp)
    when '5'
      puts 'Exit'
      break
    else
      puts 'Invalid command'
    end
    puts
  end
end
