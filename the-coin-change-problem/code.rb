#!/usr/bin/env ruby

require 'json'
require 'stringio'

#
# Complete the 'getWays' function below.
#
# The function is expected to return a LONG_INTEGER.
# The function accepts following parameters:
#  1. INTEGER n
#  2. LONG_INTEGER_ARRAY c
#

#Recurrence relation form, given unit count n and coins c1 ... ck such that n >= c1, n >=c2 ... n >= ck
# the number of ways to make coins is
#Sn = S(n-c1) + S(n-c2).... + S(n-ck)
#Sn = 0 when n < the minimum unit in C


def get_ways_memoized(n, c, memo)
  puts "N:#{n}, C:#{c.inspect}, M#{memo.inspect}"
  min_c = c.min
  puts "Found #{min_c} as the smallest c"
  if (min_c == n) then
    memo[n] = 1
    return 1
  end
  if (min_c > n) then
    memo[n] = 0
    return 0
  end
  if !memo[n].nil?
    return memo[n]
  end
  possible_cs = c.select{ |coin| coin <= n}
  puts "Possible Cs #{possible_cs.inspect}"
  # we increment by one because we
  possible_ways = 0
  possible_cs.each do |coin|
    puts "Processing n: #{n} and coin: #{coin}"
    sub_ways = get_ways_memoized(n-coin, c, memo)
    if (sub_ways >=1)
      possible_ways+=sub_ways
    end
  end
  puts "Found #{possible_ways} ways to make change for #{n}"
  memo[n] = possible_ways
  return memo[n]
end

def getWays(n, c)
  # Write your code here
  memo = Array.new(n)
  return get_ways_memoized(n, c, memo)
end

first_multiple_input = gets.rstrip.split

n = first_multiple_input[0].to_i

m = first_multiple_input[1].to_i

c = gets.rstrip.split.map(&:to_i)

# Print the number of ways of making change for 'n' units using coins having the values given by 'c'

ways = getWays n, c
puts ways