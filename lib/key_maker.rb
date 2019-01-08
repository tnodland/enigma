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
end
