class Player
    def initialize
    end
end

class Display
    def initialize
        puts "Let's play Hangman!"
    end
end

class Game
    def initialize
        word_list = File.read('wordsheet.txt')
        list = word_list.split("\n")
        @valid_words = list.select { |word| check_length(word) }
        @display = Display.new
        @player = Player.new
    end
    
    def check_length(word)
        length = word.length
        if length >= 5 && length <= 12
            true
        else
            false
        end
    end
end

game = Game.new