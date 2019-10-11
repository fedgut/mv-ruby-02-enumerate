# frozen_string_literal: true

# !/home/eduardo/.rvm/rubies/ruby-2.6.3/bin/ruby

module Enumerable
  def my_each
    i = 0
    while i < length
      if block_given?
        yield(self[i])
      else
        self[i]
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    x = 0
    while i < length
      yield(self[i], x)
      i += 1
      x = i
    end
  end

  def my_select
    return to_enum unless block_given?

    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_inject ()
end

hash = {}
arr = (1..4).to_a
myhash = {}

# %w[a b c].each_with_index { |el, i| hash[el] = i }
# puts hash
# %w[a b c].my_each_with_index { |el, i| myhash[el] = i }
# puts myhash


# puts arr.my_each_with_index

# puts arr.my_select
# puts(arr.my_select(&:even?))
