def rps(choice)
  choices = ['rock', 'paper', 'scissors']
  computers_choice = choices.shuffle.first
  string = computers_choice + ", "
  if choice == computers_choice
    string += "Draw"
  elsif choice != computers_choice
    if compare(choice, computers_choice)
      string += "Win"
    else
      string += "Lose"
    end
  end
  string
end

def compare(a, b)
  if a == 'rock'
    if b == 'scissors'
      return true
    else
      return false
    end
  end
  if a == 'paper'
    if b == 'rock'
      return true
    else
      return false
    end
  end
  if a == 'scissors'
    if b == 'paper'
      return true
    else
      return false
    end
  end
end



def remix(arr)
  alcohols = []
  mixers = []
  mix = []

  arr.each do |i|
    alcohols.push(i[0])
    mixers.push(i[1])
  end

  alcohols.shuffle!
  mixers.shuffle!

  alcohols.each_with_index do |value, i|
    mix.push([value, mixers[i]])
  end

  mix
end

p rps("rock")

p remix([["rum", "coke"],["gin", "tonic"],["scotch","soda"]])
