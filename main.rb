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

  def my_select
    result = []
    my_each { |e| result << e if yield e }
    result
  end

  def my_all?
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end

end

# test variables
array_test = [1, 2, 3, 4, 5, 6]
obj_test = { one: 1, two: 2, three: 3 }

# Method call for tests each
puts '------------Original each--------------'
array_test.each { |e| p e**2 }
obj_test.each { |e| p e }

puts '-------------This script each-----------'
array_test.my_each { |e| p e**2 }
obj_test.my_each { |e| p e }

puts '-------Original each with index---------'
array_test.each_with_index { |e, i| p e, i }
obj_test.each_with_index { |e, i| p e, i }

puts '----This script each with index---------'
array_test.my_each_with_index { |e, i| p e, i }
obj_test.my_each_with_index { |e, i| p e, i }

# Method call for tests Select
puts '-------Original select---------'
p array_test.select(&:even?)
p(obj_test.select { |_k, v| v < 2 })

puts '----This script select---------'
p array_test.my_select(&:even?)
p(obj_test.my_select { |_k, v| v < 2 })

# Method call for tests all?
