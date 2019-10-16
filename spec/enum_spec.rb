# frozen_string_literal: true

# spec/enum_spec.rb

require './lib/enum'

ar = [1, 2, 3]
ar2 = %w[ant bear cat]
ar3 = [1, 'dog', 3]
range = (1..3)
empty = []

RSpec.describe Enumerable do
  describe 'my_each' do
    it 'Return an enum if no block is given' do
      expect(ar.my_each).to be_an_instance_of(Enumerator)
    end

    it 'Iterate on array' do
      expect(ar.my_each { |i| i + 1 }).to eql([1, 2, 3])
    end

    it 'Return empty array if fed empty array' do
      expect(empty.my_each { |i| i + 1 }).to eql([])
    end

    it 'Iterate on range' do
      expect(range.each {}).to eql(range)
    end
  end

  describe '#my_each_wth_index' do
    it 'Iterate on arrays' do
      hash = {}
      ar2.my_each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to eql('ant' => 0, 'bear' => 1, 'cat' => 2)
    end

    it 'Iterate on ranges' do
      hash = {}
      range.my_each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to eql(1 => 0, 2 => 1, 3 => 2)
    end

    it 'Handles empty arr' do
      expect(empty.my_each_with_index { |i| i + 1 }).to eql([])
    end

    it 'Returns Enumerator if no block is given' do
      expect(empty.my_each_with_index).to be_an_instance_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'Iterate and select from Array.' do
      expect(ar.my_select(&:even?)).to eql([2])
    end

    it 'Iterate and select from Range' do
      expect(range.my_select(&:even?)).to eql([2])
    end

    it 'Handle Empty Array' do
      expect(empty.my_select(&:even?)).to eql([])
    end

    it 'Returns enum if no block is given' do
      expect(empty.my_select).to be_an_instance_of(Enumerator)
    end
  end

  describe '#my_all' do
    it 'Returns true for empty array and no block' do
      expect(empty.my_all?).to be_truthy
    end

    it 'Returns true for empty array and any block' do
      expect(empty.my_all?(&:even?)).to be_truthy
    end

    it 'Return true if all elem match the pattern' do
      expect(ar2.my_all?(/a/)).to eql(true)
    end

    it 'Return false if any elem doesnt match the pattern' do
      expect(ar2.my_all?(/t/)).to eql(false)
    end

    it 'Return true if all elems in arr fulfill condition' do
      expect(ar2.my_all? { |word| word.length <= 4 }).to eql(true)
    end

    it 'Return false if any elems in arr  doesnt fulfill condition' do
      expect(ar2.my_all? { |word| word.length < 4 }).to eql(false)
    end

    it 'Return true if all elems in arr are same class' do
      expect(ar.my_all?(Numeric)).to eql(true)
    end
  end

  describe 'my_any?' do
    it 'Returns false if empty arr and no block' do
      expect(empty.my_any?).to eql(false)
    end

    it 'Returns false if empty arr and any block' do
      expect(empty.my_any?(&:even?)).to eql(false)
    end

    it 'Checks if any element matches the pattern' do
      expect(ar2.my_any?(/b/)).to eql(true)
    end

    it 'Checks if any elements of the enum fulfill the block condition' do
      expect(ar2.my_any? { |word| word.length == 4 }).to eql(true)
    end
  end

  describe 'my_none' do
    it 'Returns true if empty arr and no block' do
      expect(empty.my_none?).to eql(true)
    end

    it 'Returns true if empty arr and any block' do
      expect(empty.my_none?(&:even?)).to eql(true)
    end

    it 'Checks if no elem contains the pattern' do
      expect(ar2.my_none?(/b/)).to eql(false)
    end

    it 'Checks if no elements of the enum fulfill the block condition' do
      expect(ar2.my_none? { |word| word.length == 4 }).to eql(false)
    end

    it 'Returns true if no elem in Array match' do
      expect(ar2.my_none? { |word| word.length > 5 }).to eql(true)
    end

    it 'Returns false if any elem in range match' do
      expect(range.my_none?(&:even?)).to eql(false)
    end

    it 'Returns false in any elem in the Array match Type' do
      expect(ar3.my_none? { |elem| elem.is_a?(String) }).to eql(false)
    end

    it 'Returns false if any elem of array match equality' do
      expect(ar3.my_none? { |elem| elem == 1 }).to eql(false)
    end
  end

  describe 'my_count' do
    it 'Returns zero on empty arr' do
      expect(empty.my_count).to eql(0)
    end

    it 'returns the number of elements in the enum' do
      expect(ar.my_count).to eql(3)
    end

    it 'returns the number of elements that are equal to the argument' do
      expect(ar.my_count(2)).to eql(1)
    end

    it 'returns the number of elements that satisfy the blocks conditions' do
      expect(ar.my_count(&:even?)).to eql(1)
    end
  end

  describe 'my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'Return an Enum if no block is given' do
      expect((1..4).my_map).to be_instance_of(Enumerator)
    end
  end

  describe 'my_inject' do
    it 'Accumulate on passing a block' do
      expect((5..10).my_inject { |sum, i| sum + i }).to eql(45)
    end

    it 'Accumulate on passing a symbol' do
      expect((5..10).my_inject(:+)).to eql(45)
    end

    it 'Accumulate on passing a symbol with arg' do
      expect((5..10).my_inject(1, :+)).to eql(46)
    end

    it 'Accumulate on with arg and block' do
      expect((5..10).my_inject(1) { |elem, i| elem + i }).to eql(46)
    end

    it 'Accumulate on with arg and block' do
      expect(ar.my_inject(1) { |elem, i| elem + i }).to eql(7)
    end
  end
end
