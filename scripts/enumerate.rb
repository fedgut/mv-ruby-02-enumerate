# frozen_string_literal: true

# !/home/eduardo/.rvm/rubies/ruby-2.6.3/bin/ruby

module Enumerable
  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    x = 0
    while i < length
      yield(self[i], x)
      i += 1
      x = i
    end
  end

  def my_select
    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all?
    my_each { |i| return false unless yield(i) }
    true
  end

  def my_any?
    my_each { |i| return true if yield(i) }
    false
  end

  def my_none?
    my_each { |i| return false if yield(i) }
    true
  end
end

puts %w[art ar ct].none? { |word| word.length >= 3 }
puts %w[atr ar ct].my_none? { |word| word.length >= 3 }
