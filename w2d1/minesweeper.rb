#!/usr/bin/env ruby

class Board

  def initialize(player)
    @player = player
    @hidden_grid = Array.new(9) {Array.new(9){Tile.new(self,Board.value_generator)}}
    @visible_grid = Array.new(9){Array.new(9){'*'}}
  end

  def play
    start_of_game_display

    until over?
      display_board
      @player.get_move
    end

  end

  private
    def display_board
      @visible_grid.each do |subary|
        p subary
      end
    end

    def over?

    end

    def start_of_game_display
      puts "Welcome to Mine Sweeper!"
    end

    def self.value_generator
       (rand(100) > 79) ? 1 : 0
    end

end

class Tile
  attr_reader :value

  def initialize(board, value)
    @board = board
    @value = value
  end
end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Choose a tile to reveal or flag (e.g. r, 4, 7):"

    input = gets.chomp.split(', ')
    choice = input.take(1)
    indices = input.drop(1).map(&:to_i)

    [choice, indices]
  end
end

if __FILE__ == $PROGRAM_NAME
  charlie = Player.new("Charlie")
  b = Board.new(charlie)
  b.play
end
