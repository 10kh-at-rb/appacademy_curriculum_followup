require 'byebug'

class Board
  @@winner = nil
  attr_accessor :board

  def initialize
    @board = [['-','-','-'], ['-','-','-'], ['-','-','-']]
  end

  def deep_dup
    new_board = Board.new
    new_board.board = self.board.map { |row| row.dup }
    new_board
  end

  def empty?(pos)
    if @board[pos[1]][pos[0]] == '-'
      true
    else
      false
    end
  end

  def place_mark(pos,mark)
    if empty?(pos)
      @board[pos[1]][pos[0]] = mark
    end
  end

  def won?
    #check rows
    3.times do |t|
      if winning_array?(@board[t])
        return true
      end
    end

    #check cols
    3.times do |t|
      col = [@board[0][t], @board[1][t], @board[2][t]]
      if winning_array?(col)
        return true
      end
    end

    #check diags
    if winning_array?([@board[0][0], @board[1][1], @board[2][2]])
      return true
    end
    if winning_array?([@board[2][0], @board[1][1], @board[0][2]])
      return true
    end

    false
  end

  def winning_array?(array)
    if(array[0] != '-' && array.uniq.count == 1)
      @@winner = array[0]
      return true
    end
    false
  end

  def winner
    if @@winner.nil?
      puts "No winner."
    else
      puts "Player #{@@winner} is the winner."
    end
  end

end

class Game

  def initialize()
    @board = Board.new
    @player1 = HumanPlayer.new
    @player2 = ComputerPlayer.new(@board)
  end

  def play
    puts "Welcome"
    loop do
      puts "Human, make your move"
      print_board
      mv = @player1.move
      if @board.empty?(mv)
        @board.place_mark(mv,"X")
      else
        puts "Invalid move!"
        next
      end
      if(@board.won?)
        print_board
        @board.winner
        break
      end
      puts "Thinking.."
      print_board
      @board.place_mark(@player2.move,"O")
      if(@board.won?)
        print_board
        @board.winner
        break
      end
    end
  end

  def print_board
    p @board.board[2]
    p @board.board[1]
    p @board.board[0]
  end

end

class HumanPlayer
  def move
    x = ""
    y = ""
    loop do
      puts "x-coordinate?"
      x = gets.chomp
      if x =~ /^[0-2]$/
        x = x.to_i
        break
      else
        puts "Invalid input."
        next
      end
    end


    loop do
      puts "y-coordinate?"
      y = gets.chomp
      if y =~ /^[0-2]$/
        y = y.to_i
        break
      else
        puts "Invalid input."
        next
      end
    end

    [x,y]
  end
end

class ComputerPlayer
  def initialize(board)
    @board = board
  end

  def move
    pos = analyze_board
    if pos == [-1,-1]
      pos = [rand(3), rand(3)]
      until @board.empty?(pos)
        pos = [rand(3),rand(3)]
      end

    end
    return pos
  end

  def analyze_board
    @board.board.each_with_index do |row,y|
       row.each_index do |x|
        if(@board.empty?([x,y]) == false)
          next
        else
          new_board = @board.deep_dup
          new_board.place_mark([x,y],'O')
          if new_board.won?
            return [x, y]
          end
        end
      end
    end
    [-1,-1]
  end
end
