require 'card'

describe 'Card' do
  subject(:card) {Card.new(:five, :clubs)}

  it 'should have a value' do
    expect(card.value).to eq('5')
  end

  it 'should have a suit' do
    expect(card.suit).to eq("♣")
  end

end
