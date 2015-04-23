def guessing_game
  prng = Random.new
  computer_number = prng.rand(100) + 1
  won = false
  guess_count = 0
  until won == true
    puts "Guess thus far: #{guess_count}"
    puts "Guess a number between 1 and 100."
    user_number = Integer(gets)
    guess_count += 1
    if user_number == computer_number
      won = true
    elsif user_number < computer_number
      puts "too low"
    else
      puts "too high"
    end
  end

  puts "You won in #{guess_count} guesses."
end

def shuffle_file
  puts "what file (without format) do you want to shuffle?"
  file = gets.chomp
  file_array = File.readlines("#{file}.txt")
  file_array.shuffle!

  File.open("#{file}-shuffled.txt", "w") do |f|
    f.puts file_array
  end

end
