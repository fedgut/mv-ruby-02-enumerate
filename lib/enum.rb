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
end
