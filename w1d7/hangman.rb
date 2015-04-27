#!/usr/bin/env ruby

class Game
  attr_reader :word_state

  def initialize(guesser, picker)
    @guesser = guesser
    @picker = picker
    @letter_indices = []
  end

  def play
    start_display
    @word_state = Array.new(@picker.tell_secret_word_length, nil)
    @turn_count = 7
    until over?
      game_state_display
      @letter = @guesser.guess(@word_state)
      incorporate_guess
    end
    end_game_display
  end

  private

    def end_game_display
      if @turn_count == 0
        puts "\n#{@picker.name} wins! :)"
        puts "#{@guesser.name} loses! :("
      elsif !@word_state.include?(nil)
        puts "The word is #{@word_state.join('')}!"
        puts "\n#{@guesser.name} wins! :)"
        puts "#{@picker.name} loses! :("
      end

      puts "\nThank you for playing Hangman."
      puts "Game brought to you by: Austin Gatlin"
    end

    def game_state_display
      puts @word_state.map{|el| el.nil? ? '_' : el}.join(' | ')
      puts "#{@turn_count} incorrect guesses remaining."
      puts "Guessed letters: " +  @guesser.guesses.join(', ')
    end

    def incorporate_guess
      @letter_indices = @picker.respond_to_letter_guess(@letter)
      if @letter_indices.empty?
        puts "\nNope!"
        @turn_count -= 1
      else
        puts "\nGood guess!"
      end

      @letter_indices.each{|i| @word_state[i] = @letter}
    end

    def over?
      @turn_count == 0 || !@word_state.include?(nil)
    end

    def start_display
      puts "Welcome to Hangman!\n"
    end
end

class ComputerPlayer
  attr_reader :name, :guesses

  def initialize(dictionary_file_name)
    @name = "The Computer"
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    @guesses = []
  end

  def guess(word_state)
    indices = []
    word_state.each_index{|i| word_state[i].nil? ? nil : indices << i}

    possibilities = @dictionary.select{|word| word.length == word_state.length}
    possibilities = possibilities.select do |word|
      indices.all?{|i| word[i] == word_state[i]}
    end

    letter_counts = Hash.new{|h, k| h[k] = 0}
    possibilities.each do |word|
      word.each_char do |char|
        letter_counts[char] += 1
      end
    end

    guess_letter = nil
    letter_counts.each do |key, value|
      next if @guesses.include?(key)

      if guess_letter == nil || value > letter_counts[guess_letter]
        guess_letter = key
      end
    end

    @guesses << guess_letter
    guess_letter
  end

  # Make sure the dictionary has one word per line
  def tell_secret_word_length
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  # Returns an array of indices where the letter appears in secret word.
  def respond_to_letter_guess(letter)
    indices_matching_letter = []
    i = 0
    while i < @secret_word.length
      if @secret_word[i] == letter
        indices_matching_letter << i
      end

      i += 1
    end

    indices_matching_letter
  end
end

class HumanPlayer
  attr_reader :name, :guesses

  def initialize(name)
    @name = name
    @guesses = []
  end

  def guess(word_state)
    puts "Pick a letter"

    letter = gets.chomp
    until letter =~ /\A[a-z]\z/ && !@guesses.include?(letter)
      if letter =~ /\A[a-z]\z/ && @guesses.include?(letter)
        puts "You already guessed that letter."
      end
      puts "Lowercase letters only please." if !(letter =~ /\A[a-z]\z/)
      letter = gets.chomp
    end

    @guesses << letter
    letter
  end

  def respond_to_letter_guess(letter)
    puts "At what indices does the letter #{letter} appear? (e.g., 1, 3)."
    puts "If none, just hit return"
    indices = gets.chomp.split(', ')

    indices.empty? ? indices : indices.map(&:to_i)
  end

  def tell_secret_word_length
    puts "What is the length of your word?"
    gets.chomp.to_i
  end

end

if __FILE__ == $PROGRAM_NAME
  austin = HumanPlayer.new("Austin")
  comp = ComputerPlayer.new('../dictionary.txt')
  game = Game.new(comp, austin)
  game.play
end
