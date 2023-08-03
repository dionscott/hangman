class Player
    def initialize
    end

    def get_input
        input = gets.chomp.downcase
    end
end

class Display
    def initialize
        puts "Let's play Hangman!"
    end
    # display the board
    # ask the player for input
    def display_player_input
        puts "Input a letter."
    end

    def incorrect_input
        puts "Incorrect input. Try again."
    end
end

class Game
    def initialize
        word_list = File.read('wordsheet.txt')
        list = word_list.split("\n")
        @valid_words = list.select { |word| check_length(word) }
        @display = Display.new
        @player = Player.new
        @correct_letters = []
        @incorrect_letters = []
    end
    
    def check_length(word)
        length = word.length
        if length >= 5 && length <= 12
            true
        else
            false
        end
    end

    def generate_word
        @valid_words.sample
    end

    def is_string?(string)
        if string.to_i.to_s == string
            false
        else
            true
        end
    end

    def valid_input?(string)
        true if is_string?(string) && string.length == 1
    end

    def get_player_input
        @display.display_player_input
        input = @player.get_input
        until valid_input?(input)
            @display.incorrect_input
            input = @player.get_input
        end
        puts "Correct input"
    end
end

game = Game.new
p game.generate_word
p game.get_player_input
