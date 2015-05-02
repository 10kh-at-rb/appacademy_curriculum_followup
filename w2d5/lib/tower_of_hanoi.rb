class Hanoi
  attr_accessor :board

  def initialize(player)
    @player = player
    @board = Array.new(3) {[]}

    setup_board
  end

  def move(start, stop)
    if !@board[stop].empty?
      if @board[stop].last < @board[start].last
        raise MoveError.new
      end
    end

    @board[stop]<< @board[start].pop
  end

  def over?
    (@board[1] == [3, 2, 1] || @board[2] == [3, 2, 1]) ? true : false
  end

  def play
    puts "Welcome"

    until over?
      start, stop = @player.get_move
      move(start, stop)
    end

    puts "Thanks for playing"
  end

  def setup_board
    @board[0] = [3, 2, 1]
  end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "What is your move, #{@name}? E.g.: 1,2"

    gets.chomp.split(',').map(&:to_i)
  end
end

class MoveError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  matt = Player.new('Matt')
  game = Hanoi.new(matt)
  game.play
end
