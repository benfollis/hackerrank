#!/bin/ruby

require 'json'
require 'stringio'


def comparator(s1, s2)
  if (s1.size > s2.size) then
    return 1
  end
  if (s1.size < s2.size) then
    return -1
  end
  #equal length
  (0..s1.size-1).each do |index|
    s1digit = s1[index].to_i
    s2digit = s2[index].to_i
    return -1 if s1digit < s2digit
    return 1 if s1digit > s2digit
  end
  # if you get here, they are equal by char
  return 0
end

# Complete the bigSorting function below.
def bigSorting(unsorted)
  return unsorted.sort { |a, b| comparator(a, b) }
end

n = gets.to_i

unsorted = Array.new(n)

n.times do |i|
    unsorted_item = gets.to_s.rstrip
    unsorted[i] = unsorted_item
end

result = bigSorting unsorted

puts result
