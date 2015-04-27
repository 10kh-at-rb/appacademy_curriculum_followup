class Board

  def initialize

    @grid = Array.new(9) {Array.new(9){Tile.new}}
    
  end

  def play
    start_of_game_display
  end

  private
    def display_board

    end

    def start_of_game_display
      puts "Welcome to Mine Sweeper!"
    end



end

class Tile

end
