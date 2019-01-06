require './test/test_helper'
require './lib/alphabet_soup'
require 'minitest/autorun'
require 'minitest/pride'

class AlphabetSoupTest < Minitest::Test
  def test_it_exists
    soup = AlphabetSoup.new

    assert_instance_of AlphabetSoup, soup
  end
end
