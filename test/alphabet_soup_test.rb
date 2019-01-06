require './test/test_helper'
require './lib/alphabet_soup'
require 'minitest/autorun'
require 'minitest/pride'

class AlphabetSoupTest < Minitest::Test
  def test_it_exists
    soup = AlphabetSoup.new(3, 27, 73, 20)

    assert_instance_of AlphabetSoup, soup
  end

  def test_it_has_attributes
    soup = AlphabetSoup.new(3, 27, 73, 20)

    expected = expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, soup.letters
    assert_equal 3, soup.a_shift
    assert_equal 27, soup.b_shift
    assert_equal 73, soup.c_shift
    assert_equal 20, soup.d_shift
  end
end
