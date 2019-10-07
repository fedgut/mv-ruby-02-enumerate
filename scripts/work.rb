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
    i = 0
    x = 0
    while i < length
      yield(self[i], x)
      i += 1
      x = i
    end
  end
end

# test each
# arr = [1, 2, 3, 4, 5]
# puts(arr.my_each{ |x| x + 2 })
# puts(arr.each{ |x| x + 2 })

# test each_with_index
# %w[a b c].each_with_index { |el, i| puts el => i }
hash = {}
%w[a b c].each_with_index { |el, i| hash[el] = i }
puts hash
myhash = {}
%w[a b c].each_with_index { |el, i| myhash[el] = i }
puts myhash
