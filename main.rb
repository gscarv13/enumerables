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

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield to_a[i], i
      i += 1
    end
    self
  end


end

# test variables
array_test = [1, 2, 3, 4, 5, 6]
obj_test = { one: 'hey1', two: 'hey2', three: 'hey3' }

# Method call for tests each
puts '------------Original each--------------'
array_test.each { |e| p e**2 }
obj_test.each { |e| p e }

puts '-------------This script----------------'
array_test.my_each { |e| p e**2 }
obj_test.my_each { |e| p e }

puts '-------Original each with index---------'
array_test.each_with_index { |e, i| p e, i }
obj_test.each_with_index { |e, i| p e, i }

puts '----This script each with index---------'
array_test.my_each_with_index { |e, i| p e, i }
obj_test.my_each_with_index { |e, i| p e, i }

# Method call for tests Select
# Method call for tests 
