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


def lilysHomeworkAscending(arr)
  if(arr.size == 1) then
    return 0
  end
  i = index_of_max(arr)
  last_index = arr.size-1
  swaps = 0
  if i != last_index then
    swaps +=1
    # do the swap
    temp = arr[i]
    arr[i] = arr[last_index]
  end
    # compute on the sub problem if a[0... i-1]
  swaps += lilysHomeworkAscending(arr[0, last_index])
  return swaps
end


def lilysHomeworkDescending(arr)
  if(arr.size == 1) then
    return 0
  end
  i = index_of_min(arr)
  swaps = 0
  if i != 0 then
    swaps +=1
    # do the swap
    temp = arr[i]
    arr[i] = arr[0]
  end
  # compute on the sub problem if a[1... i]
  swaps += lilysHomeworkAscending(arr[1, arr.size-1])
  return swaps
end

# Complete the lilysHomework function below.
def lilysHomework(arr)
  ascending = lilysHomeworkAscending(arr)
  descending = lilysHomeworkDescending(arr)
  return [ascending, descending].min
end

n = gets.to_i

arr = gets.rstrip.split(' ').map(&:to_i)

result = lilysHomework arr

puts result

