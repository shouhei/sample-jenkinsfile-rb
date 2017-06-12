# frozen_string_literal: true

$LOAD_PATH << 'src'
require 'minitest/autorun'
require 'minitest/unit'
require 'problem_2'

class TestProblem1 < MiniTest::Unit::TestCase
  def test_fibonacci_length_3
    assert_equal [1, 2], fibonacci(3)
  end

  def test_fibonacci_length_5
    assert_equal [1, 2, 3, 5], fibonacci(5)
  end

  def test_select_even_length_3
    assert_equal [2], select_even([1, 2, 3])
  end

  def test_select_even_length_5
    assert_equal [2, 8], select_even([1, 2, 3, 5, 8])
  end

  def test_problem2
    assert_equal 10, select_even(fibonacci(8)).inject(:+)
  end
end
