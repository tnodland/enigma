module KeyMaker
  def make_key
    key = self.generate_key

    return key.join
  end

  def generate_key
    numbers = (0..9).to_a
    key = []

    until key.length == 5
      number = numbers.sample
      key << number
    end
    return key
  end

  def key_converter(key)
    key_array = key.split ""

    @a_shift = key_array[0].to_i * 10 + key_array[1].to_i
    @b_shift = key_array[1].to_i * 10 + key_array[2].to_i
    @c_shift = key_array[2].to_i * 10 + key_array[3].to_i
    @d_shift = key_array[3].to_i * 10 + key_array[4].to_i
  end
end
