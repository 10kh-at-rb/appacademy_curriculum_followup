#!/usr/bin/env ruby

class Array
  def bubble_sort
    self.dup.bubble_sort!
  end

  def bubble_sort!
    sorted = false

    until sorted
      sorted = true

      self.each_index do |i|
        next if i == self.length - 1

        if self[i] > self[i + 1]
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def quick_sort
    return self if self.length <= 1

    pivot = self.length / 2
    left = []; right = []

    self.each_index do |i|
      next if i == pivot

      if self[i] > self[pivot]
        right << self[i]
      else
        left << self[i]
      end
    end

    left.quick_sort + [self[pivot]] + right.quick_sort
  end

  def merge_sort
    return self if self.length <= 1

    mid = self.length / 2
    left, right = self[0...mid], self[mid..-1]

    Array.merge(left.merge_sort, right.merge_sort)
  end

  def self.merge(left, right)
    merged = []

    until left.empty? || right.empty?
      merged << (right.first < left.first ? right.shift : left.shift)
    end

    merged + left + right
  end

  # Assumes the array is already sorted
  # Returns index of target. nil otherwise
  def binary_search(target)
    return nil if self.length == 0

    pivot = self.length / 2
    case self[pivot] <=> target
    when -1
      outcome = self[(pivot+1)..-1].binary_search(target)
      outcome.nil? ? nil : (outcome + 1) + pivot
    when 0
      pivot
    when 1
      self[0...pivot].binary_search(target)
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  a = [5, 4, 3, 2, 1]
  p a.bubble_sort
  p a.quick_sort
  p a.merge_sort

  b = [1, 2, 3, 4, 5]
  p b.binary_search(2)
  p b.binary_search(4)
  p b.binary_search(6)
end
