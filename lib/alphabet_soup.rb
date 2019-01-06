class AlphabetSoup

  attr_reader :letters,
              :a_shift_array,
              :b_shift_array,
              :c_shift_array,
              :d_shift_array

  def initialize(a_shift, b_shift, c_shift, d_shift)
    @letters =  ("a".."z").to_a << " "
    @a_shift_array = @letters.rotate(a_shift)
    @b_shift_array = @letters.rotate(b_shift)
    @c_shift_array = @letters.rotate(c_shift)
    @d_shift_array = @letters.rotate(d_shift)
  end

end
