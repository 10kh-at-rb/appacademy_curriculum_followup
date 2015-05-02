require_relative 'deck'

class Hand

  attr_accessor :hand

  def initialize(deck = Deck.new)
    @deck = deck
    @hand = @deck.take(5)
  end

  def flush?
    suit = @hand.first.value
    @hand.all? {|card| suit == card.value}
  end

end
