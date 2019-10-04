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
end

[1, 2, 3].my_each { |i| puts i }
[1, 2, 3].my_each_with_index { |i, x| puts i => x }
listi = Array.new(1, 2 ,3 ,4 ,5 ,6 , 7)
puts listi.my_select(&:even?)
