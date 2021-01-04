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
    result = true
    my_each { |e| result = false if yield e == false }
    result
  end

  def my_any?
    result = false
    if block_given?
      my_each { |e| result = true if yield e }
    else
      block = proc { |e| e }
      my_each { |_e| result = true if block }
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      my_each { |e| result = false if yield e }
    else
      my_each { |e| result = false if e }
    end
    result
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

puts '--------------my_each------------------'
array_test.my_each { |e| p e**2 }
obj_test.my_each { |e| p e }

# Method call for tests each_with_index
puts '-------Original each with index---------'
array_test.each_with_index { |e, i| p e, i }
obj_test.each_with_index { |e, i| p e, i }

puts '----my_each_with_index---------'
array_test.my_each_with_index { |e, i| p e, i }
obj_test.my_each_with_index { |e, i| p e, i }

# Method call for tests Select
puts '-------Original select---------'
p array_test.select(&:even?)
p(obj_test.select { |_k, v| v < 2 })

puts '----------my_select------------'
p array_test.my_select(&:even?)
p(obj_test.my_select { |_k, v| v < 2 })

# Method call for tests all?
puts '-------Original all?---------'
p(array_test.all? { |e| e.is_a?(Integer) })

puts '----------my_all?------------'
p(array_test.my_all? { |e| e.is_a?(Integer) })

# Method call for tests any?
puts '-------Original any?---------'
p(array_test.any? { |e| e.is_a?(Symbol) })

puts '----------my_any?------------'
p(array_test.my_any? { |e| e.is_a?(Symbol) })

# Method call for tests any?
puts '-------Original none?---------'
p(array_test.none? { |e| e.is_a?(Symbol) })
p [].none?                                           
p [nil].none?                                        
p [nil, false].none?                                 
p [nil, false, true].none?   

puts '----------my_none?------------'
p(array_test.my_none? { |e| e.is_a?(Symbol) })
p [].my_none?                                           
p [nil].my_none?                                        
p [nil, false].my_none?                                 
p [nil, false, true].my_none?   
