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
    key_array = key.split ""

    @a_shift = key_array[0].to_i * 10 + key_array[1].to_i
    @b_shift = key_array[1].to_i * 10 + key_array[2].to_i
    @c_shift = key_array[2].to_i * 10 + key_array[3].to_i
    @d_shift = key_array[3].to_i * 10 + key_array[4].to_i
  end

  def date_shifter(date)
    squared_date = (date.to_i) ** 2
    square_array = squared_date.to_s.split ""

    @a_shift += square_array[6].to_i
    @b_shift += square_array[7].to_i
    @c_shift += square_array[8].to_i
    @d_shift += square_array[9].to_i 
  end
end
