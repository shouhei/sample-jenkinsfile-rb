# frozen_string_literal: true

def fibonacci(max)
  l = [1, 2]
  i = 0
  while l[i - 1] + l[i] < max
    l << l[i] + l[i + 1]
    i += 1
  end
  l
end

def select_even(l)
  result = []
  l.each { |e| result << e if (e % 2).zero? }
  result
end
