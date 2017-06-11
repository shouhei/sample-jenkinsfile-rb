# frozen_string_literal: true

$LOAD_PATH << 'src'
require 'minitest/autorun'
require 'minitest/unit'
require 'problem_1'

class TestProblem1 < MiniTest::Unit::TestCase
  def test_sample
    assert_equal 233_168, sum_of_multiples_of_3_or_5
  end
end
