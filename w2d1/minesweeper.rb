#!/usr/bin/env ruby

class Board

  def self.value_generator
     (rand(100) > 79) ? 1 : 0
  end

  def initialize(player)
    @player = player
    @hidden_grid = Array.new(9) {Array.new(9){Tile.new(self,Board.value_generator)}}
    @visible_grid = Array.new(9){Array.new(9){'^'}}
  end

  def play
    start_of_game_display

    until over?
      display_board
      info = @player.get_move
      update_board(info[0],info[1])
    end

  end

  private

    def display_board
      @visible_grid.reverse.each do |subary|
        p subary
      end
    end

    def over?
      @visible_grid.none?{|subary| subary.include?('*')}
    end

    def reveal(indices)

    end

    def start_of_game_display
      puts "Welcome to Mine Sweeper!"
    end

    def update_board(choice,indices)
      if choice == 'R'
        reveal(indices)
      elsif choice == 'F'
        @visible_grid[indices[1]][indices[0]]='F'
      end
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
    choice = input[0]
    indices = input.drop(1).map(&:to_i)

    [choice, indices]
  end
end

if __FILE__ == $PROGRAM_NAME
  charlie = Player.new("Charlie")
  b = Board.new(charlie)
  b.play
end
