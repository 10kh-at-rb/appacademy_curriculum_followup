require 'tower_of_hanoi.rb'

describe 'tower_of_hanoi' do
  subject(:game) {Hanoi.new('playa')}

  it 'should initialize as a standard hanoi game ought to' do
    expect(game.board).to eq([[3, 2, 1], [], []])
  end

  describe '#move' do

    it 'should move a disk' do
      game.move(0, 1)

      expect(game.board).to eq([[3, 2], [1], []])
    end

    it 'should not stack big disk on smaller one' do
      game.move(0, 1)

      expect {game.move(0, 1)}.to raise_error(MoveError)
    end

  end

  describe '#over?' do
    it 'should return true when game over' do
      game.board = [[], [3, 2, 1], []]

      expect(game).to be_over
    end

    it 'should only return true if the game is over' do
      expect(game).to_not be_over
    end
  end

end

describe 'player' do
  subject(:matt) {Player.new('Matt')}

  it 'should have a name' do
    expect(matt.name).to eq('Matt')
  end

end
