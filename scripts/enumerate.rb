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

  def my_count
    count = 0
    my_each { |i| count += 1 if yield(i) }
    count
  end

  def my_map(block = nil)
    result = []
    if block.nil?
      my_each { |i| result.push(yield(i)) }
    else
      my_each { |i| result.push(block.call(i)) }
    end
    result
  end

  def my_inject(init = nil)
    array2 = init ? self : self[1..-1]
    init ||= self[0]
    array2.my_each { |n| init = yield(init, n) }
    init
  end
end
