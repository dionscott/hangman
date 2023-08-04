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

    def display_goodbye
        puts "Thanks for playing!"
    end

    def display_board(letter, correct_letters, incorrect_letters, tiles)
        puts "You have guessed '#{letter}'."
        puts "Correct Letters: #{correct_letters. join(", ")}"
        puts "Incorrect Letters: #{incorrect_letters. join(", ")}"
        display_tiles(tiles)
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

    def display_yes_or_no
        puts "Please enter 'y', 'yes', 'n', or 'no'."
    end

    def display_turn(turn, number_of_incorrect)
        puts "It is turn ##{turn}."
        if number_of_incorrect == 4    
            puts "Any more incorrect guesses and you lose. Choose wisely!"
        elsif number_of_incorrect == 0
            puts "There are no incorrect guesses."
        else
            puts "There are #{number_of_incorrect} incorrect guesses.
            You have #{5 - number_of_incorrect} incorrect guesses left."
        end
    end

    def play_again
        puts "That was fun. Want to play again?"
    end

    def display_win
        puts "Congrats you win!"
        play_again
    end

    def display_loss
        puts "Dang. You lost. Better luck next time."
        play_again
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
        @blanks = ""
        @turn = 0
    end
    
    def reset_game
        @correct_letters = []
        @incorrect_letters = []
        @turn = 0
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
        show_board(input)
        show_turn
    end

    def play_again
        # get player input
        valid_inputs = ["y", "yes", "n", "no"]
        @display.display_yes_or_no
        input = @player.get_input
        # check if y, n, no, or yes
        until valid_inputs.include?(input)
            @display.incorrect_input
            @display.display_yes_or_no
            input = @player.get_input
        end
        if valid_inputs.index(input) <= 1
            # reset game and start playing
            reset_game
            play_game
        else
            @display.display_goodbye
        end
    end

    def show_turn
        @display.display_turn(@turn, @incorrect_letters.length)
    end

    def show_board(input)
        @display.display_board(input, @correct_letters, @incorrect_letters, @blanks)
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

    def display_win
        @display.display_win
    end

    def display_loss
        @display.display_loss
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
            @turn += 1
            get_player_input
        end
        game_won? ? display_win : display_loss
        play_again
    end

    def game_loss?
        @incorrect_letters.length >= 5 ? true : false
    end

    def game_won?
        @blanks.include?("_") ? false : true
    end

    def game_over?
        game_loss? || game_won?
    end

    def game_over
        @game_over
    end
end
# initialize game
game = Game.new
game.play_game
