require 'pry'

class Enigma

  attr_reader :letters,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

  def initialize
    @letters = ("a".."z").to_a << " "
    @a_shift = 0
    @b_shift = 0
    @c_shift = 0
    @d_shift = 0
  end

  def key_converter(key)
    key_string = '0%o' % key
    key_array = key_string.split ""

    @a_shift = key_array[0].to_i * 10 + key_array[1].to_i
    @b_shift = key_array[1].to_i * 10 + key_array[2].to_i
    @c_shift = key_array[2].to_i * 10 + key_array[3].to_i
    @d_shift = key_array[3].to_i * 10 + key_array[4].to_i
  end
end
