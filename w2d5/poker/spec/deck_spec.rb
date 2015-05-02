require 'deck'


describe 'Deck' do
  subject(:deck) { Deck.new }

  it 'should initialize a 52-card deck' do
    expect(deck.cards.count).to eq(52)
  end

  describe '#take' do

    it 'should return the taken cards' do
      deck.cards = [[1, "♥"], [2, "♥"]]

      expect(deck.take(1)).to eq([[2, "♥"]])
    end

    it 'should remove the taken cards from the deck' do
      deck.cards = [[1, "♥"], [2, "♥"]]
      deck.take(1)

      expect(deck.cards).to eq([[1, "♥"]])
      expect(deck.cards).to_not include([2, "♥"])
    end
  end

  describe '#shuffle' do

    it 'should rearrange the deck' do
      pre_shuffle = deck.cards.last
      deck.shuffle

      expect(pre_shuffle).to_not eq(deck.cards.last)
    end

  end

end
