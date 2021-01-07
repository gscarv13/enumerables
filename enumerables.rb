# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
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
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    to_a.my_each { |e| result << e if yield e }
    result
  end

  def my_all?(arg = nil)
    result = true
    if block_given?
      my_each { |e| result = false unless yield e }
    elsif arg.is_a?(Class) && arg.class != Regexp
      my_each { |e| result = false unless e.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |e| result = false unless e.match(arg) }
    else
      block = proc { |e| e == arg }
      my_each { |_e| result = false unless block.call }
    end
    result
  end

  def my_any?(arg = nil)
    result = false
    if block_given?
      my_each { |e| result = true if yield e }
    elsif arg.is_a?(Class) && arg.class != Regexp
      my_each { |e| result = true if e.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |e| result = true if e.match(arg) }
    else
      block = proc { |e| e == arg }
      my_each { |_e| result = true if block.call }
    end
    result
  end

  def my_none?(arg = nil)
    result = true
    if block_given?
      my_each { |e| result = false if yield e }
    elsif arg.is_a?(Class) && arg.class != Regexp
      my_each { |e| result = false if e.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |e| result = false if e.match(arg) }
    else
      my_each { |e| result = false unless e }
    end
    result
  end

  def my_count(int = nil)
    count = 0
    if block_given?
      my_each { |e| count += 1 if yield e }
    elsif !int.nil?
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

  def my_inject(arg = nil, sym = nil)
    result = 1
    if arg.is_a?(Symbol)
      result = 1 if arg.to_s.include?(':*' || ':/')
      my_each { |e| result = result.public_send arg, e }
      return result
    end
    result = arg unless arg.nil?
    my_each { |e| result = yield(result, e) }
    result
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
