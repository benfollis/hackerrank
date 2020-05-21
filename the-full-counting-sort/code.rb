#!/usr/bin/env ruby

require 'json'
require 'stringio'

# counting sort from CLRS repo
def counting_sort(input, k)
  counts = Array.new(k+1)
  sorted = Array.new(input.size)
  (0..k).each { |i| counts[i] = 0 }
  input.each { |element| counts[element[0]] += 1 }
  (1..k).each { |i| counts[i] += counts[i-1] }
  (input.size-1).downto(0).each do |index|
    input_elem = input[index]
    counts_elem = counts[input_elem[0]] # ow many elements are less than this?
    # our arrays are zero indexed
    output_index = counts_elem - 1
    sorted[output_index] = input_elem
    counts[input_elem[0]] -= 1
  end
  sorted
end

# Complete the countSort function below.
def countSort(arr)
  n = arr.size
  first_half = n / 2 # this is floor
  converted = arr.each_with_index.map do |item, index|
    item[1] = '-' if index < first_half
    item[0] = item[0].to_i
    item
  end
  sorted = counting_sort(converted, 100)
  strings = sorted.map {|item| item[1]}
  puts strings.join(' ')
end

n = gets.strip.to_i

arr = Array.new(n)

n.times do |i|
  arr[i] = gets.rstrip.split
end

countSort arr

