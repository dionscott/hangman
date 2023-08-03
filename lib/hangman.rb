word_list = File.read('wordsheet.txt')
word_list

# make into an array seperate by /n
# find words that are 5 - 12 in length
# make that the array to sample from
# initialize game with that
list = word_list.split("\n")
def check_length(word)
    length = word.length
    if length >= 5 && length <= 12
        true
    else
        false
    end
end
p valid_words = list.select { |word| check_length(word) }
