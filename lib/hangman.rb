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
        unless correct_letters.empty?
            # show correct letters
            puts "Your correct guesses are #{correct_letters. join(", ")}"
        end
        unless incorrect_letters.empty?
            # show incorrect letters
            puts "Your incorrect guesses are #{incorrect_letters. join(", ")}"
        end
        # display tiles in here instead of in game
    end

    def display_tiles(tiles)
        tiles_array = tiles.split('')
        separated_tiles = tiles_array.join(' ')
        puts separated_tiles
    end

    def display_already_guessed(input)
        puts "You have already guessed #{input}. Try again."
    end

    def display_answer(answer)
        puts "The answer is #{answer}."
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
        @game_over = false
        @blanks = ""
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

    # if it is one letter and is a letter and hasn't been guessed
    def valid_input?(string)
        if is_string?(string) && string.length == 1
            if already_guessed?(string)
                @display.display_already_guessed(string)
                false
            else
                true
            end
        else
            false
        end
    end

    def get_player_input
        @display.display_player_input
        input = @player.get_input
        until valid_input?(input)
            @display.incorrect_input
            input = @player.get_input
        end
        # if letter is included in answer
        # else add to incorrect
        if input_correct?(input)
            add_to_correct_letters(input)
            change_blanks(input)
        else
            add_to_incorrect_letters(input)
        end
        
        display_tiles
        show_board(input)
    end


    def show_board(input)
        @display.display_board(input, @correct_letters, @incorrect_letters)
    end

    def display_tiles
        @display.display_tiles(@blanks)
    end

    def add_to_correct_letters(correct_input)
        @correct_letters << correct_input
    end

    def add_to_incorrect_letters(incorrect_input)
        @incorrect_letters << incorrect_input
    end

    # check if the input is correct or incorrect
    def input_correct?(input)
        @answer.include?(input)
    end

    # check if the input has already been guessed
    def already_guessed?(input)
        all_guesses = @correct_letters + @incorrect_letters
        all_guesses.include?(input)
    end

    def display_answer
        @display.display_answer(@answer)
    end

    def create_blanks
        length = @answer.length
        blank = "_"
        @blanks = blank * length
    end

    def change_blanks(input)
        string_array = @answer.split("")
        indices = string_array.each_index.select { |i| string_array[i] == input }
        indices.each { |i| @blanks[i] = input}
    end

    def play_game
        generate_word
        display_answer
        create_blanks
        display_tiles
        until game_over?
            get_player_input
        end
        
    end

    # complete game over check
    def game_over?
        @game_over
    end

    #changes the status to true
    def game_over
        @game_over = true
    end
end
# initialize game
game = Game.new
game.play_game
# check player answer against word
# if included add to correct letter
# show correct letter and placement
# if not included add to incorrect letter
# show in incorrect letter

