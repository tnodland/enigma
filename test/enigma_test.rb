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

  def test_it_can_return_message_array_of_indexes
    enigma = Enigma.new

    assert_equal [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3], enigma.index_converter("hello world")
  end

  def test_it_can_encrypt
    enigma = Enigma.new

    assert_equal ({:encryption=>"keder ohulw", :key=>"02715", :date=>"040895"}), enigma.encrypt("hello world", "02715", "040895")
    assert_equal ({:encryption=>"uktuasfttghf", :key=>"00001", :date=>"010619"}), enigma.encrypt("TEST MESSAGE", "00001", "010619")
    assert_equal ({:encryption=>"gzypvljpddhcx", :key=>"29292", :date=>"010101"}), enigma.encrypt("coverage test", "29292", "010101")
    assert_equal ({:encryption=>"gzypvljpddhcxl", :key=>"29292", :date=>"010101"}), enigma.encrypt("coverage testa", "29292", "010101")
  end

  def test_it_can_decrypt
    enigma = Enigma.new

    assert_equal ({:decryption=>"hello world", :key=>"02715", :date=>"040895"}), enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal ({:decryption=>"test message", :key=>"00001", :date=>"010619"}), enigma.decrypt("uktuasfttghf", "00001", "010619")
    assert_equal ({:decryption=>"coverage test", :key=>"29292", :date=>"010101"}), enigma.decrypt("gzypvljpddhcx", "29292", "010101")
    assert_equal ({:decryption=>"coverage testa", :key=>"29292", :date=>"010101"}), enigma.decrypt("gzypvljpddhcxl", "29292", "010101")
  end

  def test_it_can_make_keys
    enigma = Enigma.new

    key_array = enigma.generate_key

    assert_instance_of String, enigma.make_key
    assert_equal 5, key_array.length
  end

  def test_it_can_encrypt_with_limited_inputs
    enigma = Enigma.new

    expected = {:encryption=>"nfrsuabvxmj",
      :key=>"02029",
      :date=>"08012019"}

    assert_instance_of Hash, enigma.encrypt("hello world")
    
    #this test will probably fail tomorrow because the date will
    #have changed
    assert_equal expected, enigma.encrypt("hello world", "02029")
  end

  def test_it_can_adjust_shifts_for_decryption
    enigma = Enigma.new
    enigma.key_converter("21212")

    enigma.shift_converter(enigma.a_shift)
    enigma.shift_converter(enigma.b_shift)
    enigma.shift_converter(enigma.c_shift)
    enigma.shift_converter(enigma.d_shift)

    assert_equal 21, enigma.a_shift
    assert_equal 12, enigma.b_shift
    assert_equal 21, enigma.c_shift
    assert_equal 12, enigma.d_shift
  end
end
