# frozen_string_literal: true

# spec/enum_spec.rb

require './lib/enum'

ar = [1, 2, 3]
ar2 = %w[ant bear cat]
hash = {}

RSpec.describe Enumerable do
  describe '#my_each_wth_index' do
    it 'Calls block with two arguments, the item and its index, for each item in enum' do
      ar2.my_each_with_index do |item, index|
        hash[item] = index # In two lines to improve readability
      end
      expect(hash).to eql('ant' => 0, 'bear' => 1, 'cat' => 2)
    end
  end

  describe '#my_select' do
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(ar.my_select(&:even?)).to eql(1)
    end
  end

  describe '#my_all' do
    it 'the method returns whether pattern === element for every collection member' do
      expect(ar2.my_all?(/t/)).to eql(false)
    end
  end

  describe 'my_all' do
    it 'Checks if all elements of the enum fulfill the block condition' do
      expect(ar2.my_all? { |word| word.length <= 4 }).to eql(true)
    end
  end

  describe 'my_any?' do
    it 'Checks if any element matches the pattern' do
      expect(ar2.my_any?(/b/)).to eql(true)
    end
  end

  describe 'my_any?' do
    it 'Checks if any elements of the enum fulfill the block condition' do
      expect(ar2.my_any? { |word| word.length == 4 }).to eql(true)
    end
  end

  describe 'my_none' do
    it 'Checks if no elem contains the pattern' do
      expect(ar2.my_none?(/b/)).to eql(false)
    end
  end

  describe 'my_none?' do
    it 'Checks if no elements of the enum fulfill the block condition' do
      expect(ar2.my_none? { |word| word.length == 4 }).to eql(false)
    end
  end

  describe 'my_count' do
    it 'returns the number of elements in the enum' do
      expect(ar.my_count).to eql(3)
    end
  end

  describe 'my_count' do
    it 'returns the number of elements that are equal to the argument' do
      expect(ar.my_count(2)).to eql(1)
    end
  end

  describe 'my_count' do
    it 'returns the number of elements that satisfy the blocks conditions' do
      expect(ar.my_count(&:even?)).to eql(1)
    end
  end

  describe 'my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
  end

  describe 'my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect((1..4).my_map).to be_instance_of(Enumerator)
    end
  end
end
