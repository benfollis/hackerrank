#!/usr/bin/env ruby

require 'json'
require 'stringio'


# here's the rules for a score
# if the score is greater than any element in scores return 1
# if the score is less than any score in scores return scores.size + 1
# let a and b be two scores in scores indexed by i and j respectively
# if a > score > b then return i + 2 (1 for zero index, 1 because a > score )
# let c be a score in scores indexed by x
# if score = c return x + 1

# for speed we'll use binary search
def find_position(scores, start_index, end_index, score)
  used_start = start_index
  used_end = end_index
  while (true) do #we'll bail via return
    current = (used_start + used_end) / 2
    score_at_current = scores[current]
    # it's equal, we're in the right place
    return current if score_at_current == score
    # look to the right and left, because
    # if the right is less than and I'm less than the left,
    # then we are also in the right place
    score_left = (current - 1 >= 0) ? scores[current - 1] : nil
    score_right = (current +1 < scores.size) ? scores[current + 1] : nil
    #  puts "Current: #{current} Score:#{score} SAC: #{score_at_current} SL:#{score_left} SR:#{score_right}"
    return 0 if !score_left && score > score_at_current
    return scores.size if !score_right && score < score_at_current
    if score_left > score && score_right < score
      # we're not equal to the current element
      # but we're less than the one to the left and more than the one to the right
      # so now we fight for position
      if (score_at_current > score)
        return current + 1
      end
      return current
    end
    # if no cases match, we need to jump left or right
    # jump left if current > left
    if (score >= score_left) then
      # puts "jumping left"
      used_end = current
      next
    end
    #puts "jumping right"
    used_start = current + 1
  end
end

# Complete the climbingLeaderboard function below.
def climbingLeaderboard(scores, alice)
  unique_scores = scores.uniq
  #puts find_position(unique_scores, 0, (unique_scores.size - 1), 25) + 1
  #puts unique_scores.inspect
  ranks = alice.map do |score|
    find_position(unique_scores, 0, (unique_scores.size - 1), score) + 1
  end
  return ranks
end

scores_count = gets.to_i
scores = gets.rstrip.split(' ').map(&:to_i)
alice_count = gets.to_i
alice = gets.rstrip.split(' ').map(&:to_i)
result = climbingLeaderboard scores, alice
puts result