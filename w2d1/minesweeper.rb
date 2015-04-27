#!/usr/bin/env ruby

class Board

  def initialize(player)
    @player = player
    @grid = Array.new(9) {Array.new(9){Tile.new(self,Board.value_generator)}}
  end

  def play
    start_of_game_display
    display_board
  end

  private
    def display_board
      @grid.each do |subary|
        p subary.map{|x| x.value}
      end
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
  def initialize(name)
    @name = name
  end
end

if __FILE__ == $PROGRAM_NAME
  charlie = Player.new("Charlie")
  b = Board.new(charlie)
  b.play
end
