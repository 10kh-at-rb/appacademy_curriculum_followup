require 'array.rb'

describe "#my_uniq" do
  subject(:array) {[2, 4, 3, 6, 3, 3, 4, 7]}

  it "should be in the Array class" do
    expect(array).to be_a(Array)
  end

  it "shouldn't call #uniq" do
    expect(array).to_not receive(:uniq)
    array.my_uniq
  end

  it "should return unique array in the order received" do
    expect(array.my_uniq).to eq([2, 4, 3, 6, 7])
  end

end


describe '#two_sum' do

  it 'should work with an empty array' do
    expect([].two_sum).to eq([])
  end

  it 'should work with an element with one element' do
    expect([9].two_sum).to eq([])
  end

  it 'should return indicies in the right order' do
    expect([-1, 1, 1, -1].two_sum).to eq([[0, 1], [0, 2], [1, 3], [2, 3]])
  end

end

describe '#my_transpose' do

  it 'should work with an empty array' do
    expect([].my_transpose).to eq([])
  end

  it 'should work with a 1 by 1 array' do
    expect([[1]].my_transpose).to eq([[1]])
  end

  it 'should work with a 2 by 2 array' do
    expect([[1, 2], [3, 4]].my_transpose).to eq([[1, 3], [2, 4]])
  end

  it 'should raise an error if not square' do
    expect{[[1, 2, 3], [4, 5, 6]].my_transpose}
      .to raise_error(ArgumentError)
  end

end


describe '#stock picker' do
  subject(:array) {[1, -10, -5, 10]}

  it 'should work with an empty array' do

    expect(stock_picker([])).to eq([])
  end

  it 'should work with a two-day array' do
    expect(stock_picker(array.drop(2))).to eq([0, 1])
  end

  it 'should work with a multi-day array' do
    expect(stock_picker(array)).to eq([1, 3])
  end



end
