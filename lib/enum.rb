# frozen_string_literal: true

# !/home/eduardo/.rvm/rubies/ruby-2.6.3/bin/ruby

module Enumerable
  def my_each
    return to_enum unless block_given?

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
    return to_enum unless block_given?

    while i < length
      yield(self[i], x)
      i += 1
      x = i
    end
  end

  def my_select
    return to_enum unless block_given?

    count = 0
    my_each { |i| count += 1 if yield(i) }
    count
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif pattern.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless i =~ pattern }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif pattern
      my_each { |i| return true if i =~ pattern }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif pattern
      my_each { |i| return false if i =~ pattern }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
      count
    elsif arg
      my_each { |i| count += 1 if arg == i }
    else
      my_each { |i| count += 1 if i }
    end
    count
  end

  def my_map
    result = []
    return to_enum unless block_given?

    to_a.my_each { |i| result.push(yield(i)) }
    result
  end

  def my_inject(*args); end
end
