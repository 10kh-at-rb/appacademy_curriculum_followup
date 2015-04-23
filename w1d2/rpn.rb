

def calculate(formula)
  stack = []
  symbols = ["+","-","*","/"]
  formula_array = formula.split(' ')


  formula_array.each do |el|
    if(symbols.include?(el))
      a = stack.pop
      b = stack.pop
      if(el == "+")
        stack.push(a + b)
      elsif(el == "-")
        stack.push(b-a)
      elsif(el == "*")
        stack.push(a * b)
      elsif(el == "/")
        stack.push(b / a)
      end
    else
      stack.push(el.to_i)
    end
  end

  stack.pop
end

def calculator_ui(filename = '')
  if filename.empty?

    puts "Input RPN formula. Press enter to complete"
    str = ""
    loop do
      input = gets.chomp
      break if input == ""
      str << input + " "
    end

    puts calculate(str)

  else
    file_array = File.readlines(filename)
    file_array.map!{|line| line.chomp}
    puts calculate(file_array.join(' '))
  end

end


if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0] || ''
  calculator_ui filename
end
