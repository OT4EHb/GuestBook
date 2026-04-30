class Book
    def initialize()
        @messages=[]
        
    end
    def add(author, text)
        @messages.push({author:,text:,created_at: Time.now})
        puts "Message saved"
    end
    def remove(id)
        if id>0 and @messages.length>=id
            @messages.delete_at(id-1)
            puts "Deleted"
        else
            puts "Invalid id"
        end 
    end
    def show()
        puts "--- Messages ---"
        @messages.each_with_index do |message, index|
            puts "##{index+1} | #{message[:author]} [#{message[:created_at]}]"
            puts "#{message[:text]}"
        end  
    end
end

def main_put
    puts "1. Show all"
    puts "2. Add message"
    puts "3. Delete message"
    printf "4. Exit\n\n"
    printf "Choose: "
end

if __FILE__ == $0
    book=Book.new
    while true
        main_put
        case readline().chomp
            when "1"
                book.show
            when "2"
                printf "Author: "
                author = readline().chomp
                printf "Text: "
                book.add author, readline().chomp
            when "3"
                printf "Enter message number: "
                book.remove(readline.to_i)
            when "4"
                puts "Exit"
                break
            else
                puts "Invalid command"  
        end
        puts
    end
end