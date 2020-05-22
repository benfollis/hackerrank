#!/usr/bin/env ruby

# THe magic squares problem is a whole lot easier
# If you know that there is exactly one base 3x3 magic square
# and the other 7 are rotations or reflections of it
# For speed reasons, it's faster to just have a lookup table
# of all rotations, reflections, etc and just compare the resultant
# input arrays to each


require 'json'
require 'stringio'

# computes the cost of transforming a magic square based on the rule
# that transforming elment nms_ij to ms_ij is cost |nms_ij - ms_ij|
def cost_of_transformation(magic_square, non_magic_square)
  cost = 0
  (0..2).each do |row|
    (0..2).each do |column|
      magic = magic_square[row][column]
      non_magic = non_magic_square[row][column]
      cost += (non_magic - magic).abs
    end
  end
  return cost
end
# Complete the formingMagicSquare function below.
def formingMagicSquare(s)
# all 8 of them
  magic_three_squares = [
      [[8, 1, 6], [3, 5, 7], [4, 9, 2]],
      [[6, 1, 8], [7, 5, 3], [2, 9, 4]],
      [[4, 9, 2], [3, 5, 7], [8, 1, 6]],
      [[2, 9, 4], [7, 5, 3], [6, 1, 8]],
      [[8, 3, 4], [1, 5, 9], [6, 7, 2]],
      [[4, 3, 8], [9, 5, 1], [2, 7, 6]],
      [[6, 7, 2], [1, 5, 9], [8, 3, 4]],
      [[2, 7, 6], [9, 5, 1], [4, 3, 8]],
  ]
  costs = magic_three_squares.map {|ms| cost_of_transformation(ms, s)}
  return costs.min
end

s = Array.new(3)

3.times do |i|
  s[i] = gets.rstrip.split(' ').map(&:to_i)
end

result = formingMagicSquare s
puts result
