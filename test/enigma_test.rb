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

    assert_equal 2, enigma.a_shift
    assert_equal 27, enigma.b_shift
    assert_equal 71, enigma.c_shift
    assert_equal 15, enigma.d_shift
  end

  def test_it_can_use_a_date_to_adjust_the_shifts
    enigma = Enigma.new
    enigma.key_converter("02715")

    enigma.date_shifter("040895")

    assert_equal 3, enigma.a_shift
    assert_equal 27, enigma.b_shift
    assert_equal 73, enigma.c_shift
    assert_equal 20, enigma.d_shift
  end

  def test_it_can_encrypt
    enigma = Enigma.new

    assert_equal ({:encryption=>"keder ohulw", :key=>"02715", :date=>"040895"}) ,enigma.encrypt("hello world", "02715", "040895")
    assert_equal ({:encryption=>"uktuasfttghf", :key=>"00001", :date=>"010619"}), enigma.encrypt("TEST MESSAGE", "00001", "010619")
    assert_equal ({:encryption=>"gzypvljpddhcx", :key=>"29292", :date=>"010101"}), enigma.encrypt("coverage test", "29292", "010101")
    assert_equal ({:encryption=>"gzypvljpddhcxd", :key=>"29292", :date=>"010101"}), enigma.encrypt("coverage test2", "29292", "010101")
  end
end
