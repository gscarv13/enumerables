# rubocop: disable Lint/RedundantWithIndex
require_relative '../lib/enumerables'

ARRAY_SIZE = 100
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerables' do
  # variables
  let(:hash) { { one: 1, two: 2, three: 3 } }
  let(:array2) { [1, 2, 3, 4, 5, 6] }
  let(:true_array) { [1, 2i, 3.14] }
  let(:false_array) { [nil, false, true, 99] }
  let(:falsy_array) { [nil, false] }
  let(:array_all_true) { [true, true] }
  let(:array_all_same) { [1, 1] }
  let(:words) { %w[dog door rod blade] }
  let(:range) { Range.new(5, 50) }
  let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }
  let(:my_proc) { proc { |i| i * i } }
  let(:false_block) { proc { |num| num > HIGHEST_VALUE } }
  let(:block) { proc { |num| num < (LOWEST_VALUE + HIGHEST_VALUE) / 2 } }

  describe '#my each' do
    it 'Loop through the array and multiply each element' do
      expect(array2.my_each { |i| p i }).to be(array2.each { |i| p i })
    end
    it 'Return enumerator when no block is given' do
      expect(array2.my_each.inspect).to eq(array2.to_enum(:my_each).inspect)
    end
    it 'Expect to work with ranges' do
      expect(range.my_each { |i| p i }).to be(range.each { |i| p i })
    end
  end

  describe '#my_each_with_index' do
    it 'Print the actual element and its index' do
      expect(array2.my_each_with_index { |e, i| p e, i }).to be(array2.each_with_index { |e, i| p e, i })
    end
    it 'Return enumerator when no block is given' do
      expect(array2.my_each_with_index.inspect).to eq(array2.to_enum(:my_each_with_index).inspect)
    end
    it 'Expect to work with ranges' do
      expect(range.my_each_with_index { |i| p i }).to be(range.each_with_index { |i| p i })
    end
  end

  describe '#my_select' do
    it 'Return enumerator when no block is given' do
      expect(array2.my_select.inspect).to eq(array2.to_enum(:my_select).inspect)
    end
    it 'Select even numbers' do
      expect(array2.my_select(&:even?)).to eq(array2.select(&:even?))
    end
    it 'My_select range block should be equal to select block' do
      expect(range.my_select(&block)).to eq(range.select(&block))
    end
  end

  describe '#my_all?' do
    it 'It checks all the elements in the array' do
      expect(array2.my_all? { |e| e.is_a?(Integer) }).to eq(array2.all? { |e| e.is_a?(Integer) })
    end
    it 'Return true if all elements are truthy' do
      expect(array2.my_all?).to eq(array2.all?)
    end
    it 'Return false if not all elements are truthy' do
      expect(false_array.my_all?).to eq(false_array.all?)
    end
    it 'Return true if all elements are falsy' do
      expect(falsy_array.my_all?).to eq(falsy_array.all?)
    end
    it 'Return true if RegEx is found' do
      expect(words.my_all?(/d/)).to eq(words.all?(/d/))
    end
    it 'Return false if RegEx is not found' do
      expect(words.my_all?(/o/)).to eq(words.all?(/o/))
    end
    it 'Return false if pattern do not match all' do
      expect(array2.my_all?(3)).to eq(array2.all?(3))
    end
    it 'Return true if all elements are true' do
      expect(array_all_true.my_all?).to eq(array_all_true.all?)
    end
  end

  describe '#my_any?' do
    it 'It is checking if there are any symbols' do
      expect(array2.my_any? { |e| e.is_a?(Symbol) }).to eq(array2.any? { |e| e.is_a?(Symbol) })
    end
    it 'Checks if there is any false block' do
      expect(range.my_any?(&false_block)).to eq(range.any?(&false_block))
    end
    it 'Checks if there is a falsy element in the array' do
      expect(false_array.my_any?).to eq(false_array.any?)
    end
    it 'Checks if any element match the RegEx pattern' do
      expect(words.my_any?(/d/)).to eq(words.any?(/d/))
    end
    it 'Checks if any element match the given pattern' do
      expect(words.my_any?('cat')).to eq(words.any?('cat'))
    end
    it 'Checks if any element match the given pattern' do
      expect(array2.my_any?(2)).to eq(array2.any?(2))
    end
    it 'Returns true if all elements are falsy' do
      expect(falsy_array.my_any?).to eq(falsy_array.any?)
    end
  end

  describe '#my_none?' do
    it 'It checks if the current element is a symbol' do
      expect(array2.my_none? { |e| e.is_a?(Symbol) }).to eq(array2.none? { |e| e.is_a?(Symbol) })
    end
    it 'It checks if the range has no matches with given block' do
      expect(range.my_none?(&false_block)).to eq(range.none?(&false_block))
    end
    it 'It returns true if no strings' do
      expect(array2.my_none?(String)).to eq(array2.none?(String))
    end
    it 'It returns false if numeric class is found' do
      expect(array2.my_none?(Numeric)).to eq(array2.none?(Numeric))
    end
    it 'It returns true if no regex is found' do
      expect(words.my_none?(/z/)).to eq(words.none?(/z/))
    end
    it 'It returns false if regex is found' do
      expect(words.my_none?(/d/)).to eq(words.none?(/d/))
    end
    it 'It returns true if the pattern is not found' do
      expect(words.my_none?(5)).to eq(words.none?(5))
    end
  end

  describe '#my_count' do
    it 'It counts how many elements correspond to the given argument' do
      expect(array2.my_count(2)).to eq(array2.count(2))
    end
    it 'It returns the total number of elements in the range if no block is given' do
      expect(range.my_count).to eq(range.count)
    end
  end

  describe '#my_map' do
    it 'Create a new array from multplying all range elements' do
      expect(range.my_map { |i| i * i }).to eq(range.map { |i| i * i })
    end
    it 'Create a new array from multplying all range elements' do
      expect(array2.my_map { |i| i + i }).to eq(array2.map { |i| i + i })
    end
  end

  describe '#my_inject' do
    it 'Add all elements by accepting block' do
      expect(array2.my_inject { |sum, n| sum + n }).to eq(array2.inject { |sum, n| sum + n })
    end

    it 'Accept symbol as argument' do
      expect(array2.my_inject(:*)).to eq(array2.inject(:*))
    end

    it 'Accept initail value and operator' do
      expect(array2.my_inject(20, :*)).to eq(array2.inject(20, :*))
    end
  end

  describe '#multiply_els' do
    it 'Multiply all elements and return the result' do
      expect(multiply_els(array2)).to eq(array2.my_inject(:*))
    end
  end
end

# rubocop: enable Lint/RedundantWithIndex
