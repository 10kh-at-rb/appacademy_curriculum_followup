def factors(n)
  factors = []
  (1..n).to_a.each do |val|
    if (n % val == 0)
      factors << val
    end
  end

  factors
end

def bubble_sort(arr)
  sorted = false

  until sorted
    sorted = true
    arr[0..-2].each_with_index do |val,i|
      if(val > arr[i + 1])
        sorted = false
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
      end
    end
  end

  arr
end

def substrings(string)
  substrs = []
  (string.size + 1).times do |s|
    ((string.size + 1) - s).times do |e|
      next if e == 0
      substrs.push(string[s, e])
    end
  end
  substrs
end

def subwords(string)
  substrs = substrings(string)

  dictionary = File.readlines('./dictionary.txt')
  dictionary.map!{|line| line.chomp}

  words = []
  substrs.each do |sub|
    if dictionary.include?(sub)
      words << sub
    end
  end

  words
end

# p factors(100)
# p bubble_sort([4,3,2,1,0,-1])
# p substrings('cat')
p subwords('cat')
