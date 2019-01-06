class AlphabetSoup

  attr_reader :letters,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

  def initialize(a_shift, b_shift, c_shift, d_shift)
    @letters =  ("a".."z").to_a << " "
    @a_shift = a_shift
    @b_shift = b_shift
    @c_shift = c_shift
    @d_shift = d_shift
  end

  def rotate_alphabet(shift)
    return @letters.rotate(shift)
  end
end
