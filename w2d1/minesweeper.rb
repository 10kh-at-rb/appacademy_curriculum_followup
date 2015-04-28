#!/usr/bin/env ruby

class Board
  attr_reader :hidden_grid
  def self.value_generator
     (rand(100) > 79) ? 'M' : '-'
  end

  def initialize(player)
    @player = player
    @hidden_grid = Array.new(9){Array.new(9){0}}
    @visible_grid = Array.new(9){Array.new(9){'*'}}
    @revealed_indices = {}
  end

  def play
    populate_hidden_grid
    start_of_game_display

    # DELETE THIS EVENTUALLY
    display_hidden_board
    puts

    until over?
      display_board
      info = @player.get_move
      update_board(info[0],info[1])
    end

    display_board
    end_of_game_display
  end

  private

    def display_board
      @visible_grid.reverse.each do |subary|
        p subary
      end
    end

    def display_hidden_board
      @hidden_grid.reverse.each do |subary|
        p subary.map{|tile| tile.value}
      end
    end

    def end_of_game_display
      puts "Thanks for playing!"
    end

    def over?
      @visible_grid.none?{|subary| subary.include?('*')}
    end

    def populate_hidden_grid
      @hidden_grid.map!.with_index do |subary, i|
        subary.map!.with_index do |val, j|
          Tile.new(self, Board.value_generator,[i,j])
        end
      end
    end

    def reveal(indices)
      @revealed_indices[indices] = nil

      tile = @hidden_grid[indices[0]][indices[1]]
      if tile.value == 1
        puts "you lose and you suck!"
        @visible_grid = @hidden_grid.map{|tile| tile.value}
      else
        reveal_number_on_tile(tile,indices)
      end
    end

    def reveal_neighbors_numbers(tile, indices)
      neighbors = tile.get_neighbors

      neighbors.each do |neighbor|
        if @revealed_indices.has_key?(neighbor.indices)
          next
        else
          reveal(neighbor.indices)
        end
      end
    end

    def reveal_number_on_tile(tile,indices)
      num = tile.get_tile_number
      if num > 0
        @visible_grid[indices.last][indices.first] = num
      else
        @visible_grid[indices.last][indices.first] = '-'
        #tell neigbours to reveal their numbers
        reveal_neighbors_numbers(tile, indices)
      end
    end

    def start_of_game_display
      puts
      puts "Welcome to Mine Sweeper!"
      puts
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
  attr_reader :value, :indices
  NEIGHBORS = [
    [-1,1],
    [-1, 0],
    [-1,-1],
    [1,1],
    [1,0],
    [1,-1],
    [0,1],
    [0,-1]
  ]

  def initialize(board, value, indices)
    @board = board
    @value = value
    @indices = indices
  end

  def get_neighbors
    neighbor_array = []

    NEIGHBORS.each do |(dx, dy)|
      new_indices = [@indices.first + dx, @indices.last + dy]
      next if new_indices.any?{|value| value < 0 || value > 8}
      neighbor_array << @board.hidden_grid[new_indices.last][new_indices.first]
    end

    neighbor_array
  end

  def get_neighbor_number
    #should get all 8 NEIGHBORS to reveal their number
    #and reveal their neighbors if empty

    #we should create a hash if the tile has already been called and revealed
  end

  def get_tile_number
    counter = 0
    neighbors = get_neighbors
    neighbors.each{|neigh| counter += 1 if neigh.value == 'M'}
    counter
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
