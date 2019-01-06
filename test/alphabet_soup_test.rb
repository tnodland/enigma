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

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expected_a_shift_array = ["d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c"]
    expected_c_shift_array = ["t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s"]
    expected_d_shift_array = ["u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t"]

    assert_equal expected, soup.letters
    assert_equal expected_a_shift_array, soup.a_shift_array
    assert_equal expected, soup.b_shift_array
    assert_equal expected_c_shift_array, soup.c_shift_array
    assert_equal expected_d_shift_array, soup.d_shift_array
  end

end
