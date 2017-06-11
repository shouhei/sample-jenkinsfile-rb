# frozen_string_literal: true

def sum_of_multiples_of_3_or_5
  (0..999).to_a.select { |i| (i % 3).zero? || (i % 5).zero? }.reduce(:+)
end
