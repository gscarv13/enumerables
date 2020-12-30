module Enumerable
  def my_each
    # your code here
  end
end

# test variables
array_test = [1, 2, 3, 4, 5, 6]
obj_test = { one: 'hey1', two: 'hey2', three: 'hey3' }

puts 'Original each'
array_test.each { |e| e**2 }
obj_test.each { |e| p e }

puts 'Our script'
array_test.my_each { |e| e**2 }
obj_test.my_each { |e| p e }
