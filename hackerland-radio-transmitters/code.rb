#!/usr/bin/env ruby
require 'json'
require 'stringio'

# Class from CLRS excercise, with removal extension

class CountingQuery

  def initialize(input, k)
    @counts = Array.new(k + 1)
    @k = k
    (0..k).each { |i| @counts[i] = 0 }
    input.each { |element| @counts[element] += 1 }
    (1..k).each { |i| @counts[i] += @counts[i - 1] }
  end

  def query(a, b)
    # the range is inclusive, so you don't want to
    # exclude the elements in a from your result
    return @counts[b] - @counts[a - 1]
  end

  # removes all elements in the range of a to b, inclusive
  def remove(a, b)
    puts "Removing between #{a} and #{b}"
    (a..b).each { |i| @counts[i] = 0 }
    (1..@k).each { |i| @counts[i] += @counts[i - 1] }
  end

end

def hrtHelper(counter, x, k)
  count = 0
  while(!x.empty?) do
# computes the number of houses covered by a transmitter at that house address
  coverage = x.map { |address| counter.query([1, address - k].max, [address + k, 10000].min) }
  # now finds the first such house where we can put a transmitter
  most_coverage = coverage.max
  house_index = coverage.index(most_coverage)
  #OK, we've placed an antenna, remove all houses + or -k from that house
  house_number = x[house_index]
  puts "Placing radio at #{house_number}"
  count+=1
  counter.remove([house_number-k, 0].max, [house_number+k, 10000].min)
  x = x.select {|elem| elem < (house_number-k) || elem > (house_number+k)}
  end
  return count
end

# Complete the hackerlandRadioTransmitters function below.
def hackerlandRadioTransmitters(x, k)
  puts "Placing Transmitters"
  counter = CountingQuery.new(x, 10000)
  return hrtHelper(counter, x, k)
end

nk = gets.rstrip.split
n = nk[0].to_i
k = nk[1].to_i
x = gets.rstrip.split(' ').map(&:to_i)

result = hackerlandRadioTransmitters x, k
puts result
