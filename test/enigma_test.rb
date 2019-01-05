require './test/test_helper'
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_has_attributes
    enigma = Enigma.new

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, enigma.letters
    assert_equal 0, enigma.a_shift
    assert_equal 0, enigma.b_shift
    assert_equal 0, enigma.c_shift
    assert_equal 0, enigma.d_shift
  end

  def test_it_can_convert_key_into_shifts
    enigma = Enigma.new

    enigma.key_converter("02715")

    assert_equal 02, enigma.a_shift
    assert_equal 27, enigma.b_shift
    assert_equal 71, enigma.c_shift
    assert_equal 15, enigma.d_shift
  end

  def test_it_can_use_a_date_to_adjust_the_shifts
    enigma = Enigma.new
    enigma.key_converter("02715")

    engima.date_shifter("040895")
  end

  def test_it_can_encrypt
    skip
    enigma = Enigma.new

    enigma.encrypt("hello world", 02715, )

  end
end
