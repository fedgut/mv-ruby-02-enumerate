# frozen_string_literal: true

# spec/enumerate_spec.rb

require './lib/enum'

ar = [1, 2, 3]

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'Behave as each, call block once for each element in self and convert multiple elements from yield to array' do
      expect(ar.my_each { |n| n + 1 }).to eql(ar.each { |n| n + 1 })
    end
  end

  describe '#my_each_wth_index' do
    it 'Calls block with two arguments, the item and its index, for each item in enum' do
      hash = {}
      %w[cat dog wombat].my_each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to eql('cat' => 0, 'dog' => 1, 'wombat' => 2)
    end
  end

  describe '#my_select' do
    it 'Returns an array containing all elements of enum for which the given block returns a true value.' do
      expect(ar.my_select(&:even?)).to eql(1)
    end
  end
end
