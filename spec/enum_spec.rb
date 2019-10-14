# frozen_string_literal: true

# spec/enum_spec.rb

require './lib/enum'

ar = [1, 2, 3]
ar2 = %w[ant bear cat]
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
      expect(range.each { |i| i + 1 }).to eql(range)
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
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(ar.my_select(&:even?)).to eql([2])
    end
  end

  describe '#my_all' do
    it 'the method returns whether pattern === element for every collection member' do
      expect(ar2.my_all?(/t/)).to eql(false)
    end

    it 'Checks if all elements of the enum fulfill the block condition' do
      expect(ar2.my_all? { |word| word.length <= 4 }).to eql(true)
    end
  end

  describe 'my_any?' do
    it 'Checks if any element matches the pattern' do
      expect(ar2.my_any?(/b/)).to eql(true)
    end

    it 'Checks if any elements of the enum fulfill the block condition' do
      expect(ar2.my_any? { |word| word.length == 4 }).to eql(true)
    end
  end

  describe 'my_none' do
    it 'Checks if no elem contains the pattern' do
      expect(ar2.my_none?(/b/)).to eql(false)
    end

    it 'Checks if no elements of the enum fulfill the block condition' do
      expect(ar2.my_none? { |word| word.length == 4 }).to eql(false)
    end
  end

  describe 'my_count' do
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

    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect((1..4).my_map).to be_instance_of(Enumerator)
    end
  end

  describe 'my_inject' do
    it 'accumulates and returns the result of passing each elem of the enumerator to a block or a symbol ' do
      expect((5..10).my_inject { |sum, i| sum + i }).to eql(45)
    end
  end
end
