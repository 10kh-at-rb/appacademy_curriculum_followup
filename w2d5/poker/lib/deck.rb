require_relative 'card.rb'

class Deck

  attr_accessor :cards

  def initialize
    @cards = Deck.starting_deck
  end

  def shuffle
    @cards.shuffle!
  end

  def self.starting_deck
    cards = []
    Card::VALUE_STRINGS.each_value do |value|
      Card::SUIT_STRINGS.each_value do |suit|
        cards << Card.new(value, suit)
      end
    end

    cards.shuffle
  end

  def take(n)
    takes = []
    n.times{ takes << @cards.pop }
    takes
  end

end
