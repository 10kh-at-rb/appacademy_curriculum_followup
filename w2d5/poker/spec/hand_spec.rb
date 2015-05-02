require 'hand'

describe 'hand' do
  subject(:hand) {Hand.new}

  it 'initializes with 5 cards' do
    expect(hand.hand.count).to eq(5)
  end

  describe '#flush?' do


    it 'return true for a flush' do
      deck = double("deck")
      # expect(deck).to receive(:take).with(5)


      expect(hand).to be_flush
    end

    it 'return false for not a flush' do
      deck = double("deck")

      expect(hand).not_to be_flush
    end

  end

end
