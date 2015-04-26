#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?

  prev_ary_sum = sum_recur(array.take(array.length - 1))
  prev_ary_sum + array.last
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return true if array.last == target
  return false if array.empty?

  includes?(array[0...-1], target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?

  prev_count = num_occur(array[0...-1], target)

  array.last == target ? prev_count + 1 : prev_count
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12

  add_to_twelve?(array[1..-1])
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return true if array.length < 2

  array[0] <= array[1] && sorted?(array[1..-1])
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

# def reverse(number)
#   return number if number < 10
#
#   num = number
#   count = 0
#   until num < 10
#     num /= 10
#     count += 1
#   end
#
#   new_number = number - num*(10**count)
#
#   (reverse(new_number) * 10) + num
# end

def reverse(number)
  return number if number < 10
  dig = number % 10

  count = 0
  num = number
  until num < 10
    num /= 10
    count += 1
  end

  dig*(10**count) + reverse(number/10)
end
