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

    def display_board(letter, correct_letters, incorrect_letters)
        puts "You have guessed '#{letter}'"
    end

    def display_tiles(answer, matches)
        # take answer and matches
        # show tabs = answer length
        length = answer.length
        blanks = "_ "
        total_blanks = blanks * length
        puts total_blanks
        # fill in correct matches
    end
end

class Game
    def initialize
        word_list = File.read('wordsheet.txt')
        list = word_list.split("\n")
        @valid_words = list.select { |word| check_length(word) }
        @answer = ""
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
        @answer = @valid_words.sample
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
        show_board(input)
    end

    def show_board(input)
        @display.display_board(input, @correct_letters, @incorrect_letters)
    end

    def display_tiles
        @display.display_tiles(@answer, @correct_letters)
    end
end
# initialize game
game = Game.new
# generate the game word
p game.generate_word
# show the number of places for board
game.display_tiles
# get player input
p game.get_player_input
# check player answer against word
# if included add to correct letter
# show correct letter and placement
# if not included add to incorrect letter
# show in incorrect letter