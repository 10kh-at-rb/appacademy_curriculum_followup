def super_print(string, options = {})
  defaults = {
    :times => 2,
    :upcase => false,
    :reverse => false
  }

  options = defaults.merge(options)

  (options[:times]).times do |t|
    st = string.dup
    options[:upcase] ? st.upcase! : st
    options[:reverse] ? st.reverse! : st
    puts st
  end
end

super_print("Hello")
super_print("Hello", :times => 3)
super_print("Hello", :upcase => true)
super_print("Hello", :upcase => true, :reverse => true)

options = {}
super_print("hello", options)
