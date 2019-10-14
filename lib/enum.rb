# frozen_string_literal: true

# !/home/eduardo/.rvm/rubies/ruby-2.6.3/bin/ruby

module Enumerable
  def my_each
    return to_enum unless block_given?

    to_a.length.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    to_a.length.times { |i| yield(to_a[i], i) }
    self
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |i| arr.push(i) if yield(i) }
    arr
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

  def my_inject(*args)
    init, symbol = param_identity(*args)

    array = init ? to_a : to_a[1..-1]
    init ||= to_a[0]
    if block_given?
      array.my_each { |elem| init = yield(init, elem) }
    elsif symbol
      array.my_each { |elem| init = init.send(symbol, elem) }
    end
    init
  end

  def param_identity(*args)
    init, symbol = nil
    args.my_each do |arg|
      init = arg if arg.is_a? Numeric
      symbol = arg unless arg.is_a? Numeric
    end
    [init, symbol]
  end
end
