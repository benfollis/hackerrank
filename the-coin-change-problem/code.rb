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

# this doesn't work, becasue I need to store the coin decomposition
# because the problem views (2,1) as the same as (1,2)
def get_ways_memoized(n, c, memo, coins)
  if (n < 0) then
    return 0
  end
  min_c = c.min
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
  possible_ways = 0
  c.each do |coin|
    if (coin == n) then
      possible_w# ays += 1
      next
    end
    puts "Processing n: #{n} and coin: #{coin}"
    sub_ways = get_ways_memoized(n-coin, c, memo)
    possible_ways += sub_ways
  end
  # if c == n then the above won't count c itself because it will try to recursively figure out n=c = 0. which is 0


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