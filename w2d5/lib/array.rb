class Array

  def my_uniq
    output = []
    self.each do |el|
      if !output.include?(el)
        output << el
      end
    end

    output
  end

  def two_sum
    output = []

    self.each_with_index do |el, i|
      (i...self.length).each do |j|
        output << [i, j] if self[i] + self[j] == 0
      end
    end

    output
  end

  def my_transpose
    output = []

    (0...self.length).each do |i|
      raise ArgumentError.new if self.length != self[i].length
    end

    (0...self.length).each do |column|
      new_row = []
      (0...self.length).each do |row|
        new_row << self[row][column]
      end
      output << new_row
    end

    output
  end

end

def stock_picker(array)
  output = []
  biggest_value = -1_000_000_000_000
  array.each_with_index do |price, buy_day|
    ((buy_day + 1)...array.length).each do |sell_day|
      if array[sell_day] - array[buy_day] > biggest_value
        biggest_value = array[sell_day] - array[buy_day]
        output = [buy_day, sell_day]
      end
    end
  end

  output
end
