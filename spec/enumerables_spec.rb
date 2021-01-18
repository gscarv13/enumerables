require_relative '../lib/enumerables'

ARRAY_SIZE = 100
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'Enumerables' do
  # variables
  let(:hash) { { one: 1, two: 2, three: 3 } }

  let(:array1) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
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
      expect(array2.my_each { |i| i * i }).to be(array2.each { |i| i * i })
    end
  end

  describe '#my_each_with_index' do
    it 'Print the actual element and its index' do
      expect(array2.my_each_with_index { |e, i| p e, i }).to be(array2.each_with_index { |e, i| p e, i })
    end
  end

  describe '#my_select' do
    it 'Select even numbers' do
      expect(array2.my_select(&:even?)).to eq(array2.select(&:even?))
    end
  end
end
