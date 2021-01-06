module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      if is_a? Array
        yield self[i]
      elsif is_a? Hash
        yield keys[i], self[keys[i]]
      elsif is_a? Range
        yield to_a[i]
      end
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
    to_a.my_each { |e| result << e if yield e }
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

  def my_map(proc_arg = nil)
    return to_enum(:my_map) unless block_given? || !proc_arg.nil?

    ary = []
    if proc_arg.nil?
      my_each { |e| ary << (yield e) }
    else
      my_each { |e| ary << proc_arg.call(e) }
    end
    ary
  end

  def my_inject
    result = 1
    my_each { |e| result = yield(result, e) }
    result
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
end
