#!/usr/bin/env ruby
#

def encryption(s)
  spaces_removed = s.gsub(" ", "")
  num_columns = Math.sqrt(spaces_removed.size).ceil
  matrix = Array.new(num_columns)
  num_columns.times {|index| matrix[index] = []}
  spaces_removed.each_char.with_index do |char, index|
    target_column = index % num_columns
    column = matrix[target_column]
    column << char
  end
  strings = matrix.map {|column| column.join('')}
  output = strings.join(' ')
  return output
end

s = gets.to_s.rstrip

result = encryption s

puts result
