#!/bin/ruby

#general idea here is to just pick any two letters and
#remove all the rest, then check to see if it's a valid
#string. If so record the length, and return the max such length


require 'json'
require 'stringio'
require 'set'

def all_pairs(set)
  array_form = set.to_a
  pairs=[]
  (0..set.size-2).each do |i|
    (i+1..set.size-1).each do |j|
      pairs.push([array_form[i], array_form[j]])
    end
  end
  return pairs
end

def valid?(s)
  (0..s.size-1).each do |index|
    next_pos = index + 1
    current_char = s[index]

    if (index == s.size-1) then
      return true
    end
    next_char=s[next_pos]
    return false if current_char == next_char
  end
end 


        # Complete the alternate function below.
def alternate(s)
  puts s
  char_set = Set[]
  (0..s.size-1).each {|index| char_set.add(s[index]) }
  candidates = all_pairs(char_set)
  max = 0
  candidates.each do |candidate|
    s_chars = s.split('')
    removed = s_chars.select { |char| candidate.include?(char) }.join('')
    if valid?(removed) && removed.size > max then
      max = removed.size
    end
  end
  return max
end
  

endl = gets.strip.to_i

s = gets.chomp

result = alternate s
puts result

