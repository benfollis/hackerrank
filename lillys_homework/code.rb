#!/bin/ruby

require 'json'
require 'stringio'

# Complete the lilysHomework function below.
# an array will be beutiful IFF it is in sorted order (ascending or descending)
# so we need to find the max (or the min) and record if we had to swap it to get where
# we are going

def index_of_max(array)
  array.each_with_index.max[1]
end

def index_of_min(array)
  array.each_with_index.min[1]
end


def build_position_index(data)
  index = {}
  data.each_with_index do |item, position|
    index[item] = position
  end
  return index
end
                              
# not this will fail with duplicated elements
# but the problem says distinct is fine
# to make work with distinct, we'd need to maintain a list of elements
# in the positions array, and shrink it as we consume them
def count_swaps(source, dest)
#  puts source.inspect
#  puts dest.inspect
  source_positions = build_position_index(source)
#  puts source_positions.inspect
  dest_positions = build_position_index(dest)
#  puts dest_positions.inspect
  scratchpad = source.clone
  swaps = 0;
  current_position = 0
  while (current_position < source.size - 1) do
#    puts scratchpad.inspect
    current_num = scratchpad[current_position]
    current_dest_num = dest[current_position]
#    puts "Position #{current_position} Current: #{current_num} Dest #{current_dest_num}"
    if (current_num != current_dest_num) then
      correct_position = dest_positions[current_num]
      current_occupier = scratchpad[correct_position]
#      puts "Found #{current_occupier} where #{current_num} should be"
#      puts "Should swap item at #{current_position} with item at #{correct_position}"
      # record the swap
      swaps += 1
      scratchpad[current_position] = current_occupier # do the swap
      scratchpad[correct_position] = current_num
      # update our position index
      # don't need to update dests, because it's never changing
      source_positions[current_num] = correct_position
    else
      current_position += 1
    end
  end
  return swaps
end


# Complete the lilysHomework function below.
def lilysHomework(source)
  ascending = source.sort
  descending = ascending.reverse
  ascending_swaps = count_swaps(source, ascending)
  descending_swaps = count_swaps(source, descending)
  return [ascending_swaps, descending_swaps].min
end

n = gets.to_i

arr = gets.rstrip.split(' ').map(&:to_i)

result = lilysHomework arr

puts result

