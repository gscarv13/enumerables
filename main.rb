module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield to_a[i]
      i += 1
    end
    self
  end
end

# test variables
array_test = [1, 2, 3, 4, 5, 6]
obj_test = { one: 'hey1', two: 'hey2', three: 'hey3' }

# Method call for tests
puts '------------Original each--------------'
array_test.each { |e| p e**2 }
obj_test.each { |e| p e }

puts '-------------This script----------------'
array_test.my_each { |e| p e**2 }
obj_test.my_each { |e| p e }
