#!/bin/ruby

require 'json'
require 'stringio'

# Complete the camelcase function below.
def camelcase(s)
  return 0 if s.empty?
  count=1
  (0..s.size-1).each do |index|
    char = s[index]
    # are we uppercase
    count+=1 if char == char.upcase
  end
  return count
end

s = gets.to_s.rstrip

result = camelcase s

puts result
