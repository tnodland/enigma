class Enigma

  attr_reader :letters 

  def initialize
    @letters = ("a".."z").to_a << " "
  end
end
