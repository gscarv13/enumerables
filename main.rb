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

  def my_count(int = 0)
    count = 0
    if block_given?
      my_each { |e| count += 1 if yield e }
    elsif int != 0
      my_each { |e| count += 1 if e == int }
    else
      my_each { |_e| count += 1 }
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    ary = []
    if is_a? Range
      ary1 = to_a
      ary1.my_each { |e| ary << (yield e) }
    else
      my_each { |e| ary << (yield e) }
    end
    ary
  end

  def my_inject
    result = 1
    if is_a? Range
      ary1 = to_a
      ary1.my_each { |e| result = yield(result, e) }
    else
      my_each { |e| result = yield(result, e) }
    end
    result
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
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

# Method call for tests none?
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

# Method call for tests count
puts '-------Original count---------'
ary = [1, 2, 4, 2]
p ary.count
p ary.count(2)
p(ary.count { |x| (x % 2).zero? })

puts '----------my_count------------'
ary = [1, 2, 4, 2]
p ary.my_count
p ary.my_count(2)
p(ary.count { |x| (x % 2).zero? })

# Method call for tests map
puts '-------Original map---------'
p((1..4).map { |i| i * i })
p(array_test.map { |i| i * i })

puts '----------my_map------------'
p((1..4).my_map { |i| i * i })
p(array_test.my_map { |i| i * i })

# Method call for tests inject
puts '-------Original inject---------'
p((5..10).inject { |sum, n| sum + n })
p(array_test.inject { |sum, n| sum + n })

puts '----------my_inject------------'
p((5..10).my_inject { |sum, n| sum + n })
p(array_test.my_inject { |sum, n| sum + n })

puts '----------multiply_els------------'
p(multiply_els(array_test))
