#!/bin/ruby

require 'json'
require 'stringio'

# Counting sort is O(k) where k ranges on the input order
# in this case k is _much_ less than N, so can be figured as constant tome

# Complete the activityNotifications function below.

#counting sort
def get_ith_sorted_element(i, counts)
  #puts counts.inspect
  so_far = 0
  counts.each_with_index do |count, index|
    # count can be nill if the price isn't encountered
    # so coerce it to 0
    so_far = so_far + (count || 0)
    if so_far >= i then
      #puts "Returning #{index} as the #{i}th element"
      return index
    end
  end
end


def activityNotifications(expenditure, d)
  # this is derived from counting sort
  counts = [];
  # if even then the elements we want are the d / 2 and d/2+1 elements of the counts (the sum of the middle elements)


  # this variables will help us maintain the counts
  
  last = nil
  window = [] # used to figure out what to increment and decrement
  num_notifications = expenditure.inject(0) do |num_alerts, amount|
    if !last.nil? then
      previous = counts[last] || 0
      #puts "last #{last} previous #{previous}"
      counts[last] = previous + 1
      window.push(last)
    end
    last = amount
    if (window.size < d) then
      next num_alerts # do nothing, we haven't accumulated enough data yet
    end
    if (window.size > d) then
      to_drop = window.shift()
      counts[to_drop] = counts[to_drop] - 1
    end
    #debug only
    #puts window.sort.inspect
    if (d % 2 == 0) then
      m1 = get_ith_sorted_element(d/2, counts)
      m2 = get_ith_sorted_element((d/2) + 1, counts)
      #puts("M1 #{m1} M2 #{m2}")
      alert_level = m1 + m2; # since we're going to devide by 2 anyways
    else
      target = (d*1.0/2).ceil
      puts("Looking for the #{target} element")
      median = get_ith_sorted_element(target, counts)
      alert_level = median * 2
    end
    #puts "Alert level #{alert_level} amount #{amount}"
    if alert_level == 0 && amount == 0 then
      next num_alerts #special case, for everything 0
    end
    if alert_level > amount then
      next num_alerts
       # we're not rising the the alert level
    end
    #puts "Alerting on amount #{amount}"
    num_alerts + 1 # all other cases when we don't alert have been exhausted
  end
  puts "We found #{num_notifications} alerts"
  return num_notifications
end


nd = gets.rstrip.split

n = nd[0].to_i

d = nd[1].to_i

expenditure = gets.rstrip.split(' ').map(&:to_i)

result = activityNotifications expenditure, d

puts(result)
