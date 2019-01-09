require 'pry'
require './lib/alphabet_soup'
require './lib/key_maker'
require './lib/shifter'
require './lib/converter'

class Enigma
  include KeyMaker
  include Shifter
  include Converter

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

  def index_converter(message)
    message = message.downcase
    message_array = message.split ""
    index_array = []
    message_array.each do |message_letter|
      @letters.each do |letter|
        index_array << @letters.index(letter)  if message_letter == letter
      end
    end
    return index_array
  end

  def encrypt(message, key = make_key, date = Time.now.strftime("%d%m%Y"))
    encryption_hash = {encryption: "", key: key, date: date}
    self.key_converter(key)
    self.date_shifter(date)
    index_array = self.index_converter(message)
    encrypted_message_array = []
    soup = AlphabetSoup.new(@a_shift, @b_shift, @c_shift, @d_shift)
    self.conversion_loop(index_array, encrypted_message_array, soup, encryption_hash)
  end

  def decrypt(ciphertext, key, date)
    decryption_hash = {decryption: "", key: key, date: date}
    self.key_converter(key)
    self.date_shifter(date)
    index_array = self.index_converter(ciphertext)
    soup = AlphabetSoup.new(self.shift_converter(@a_shift), self.shift_converter(@b_shift), self.shift_converter(@c_shift), self.shift_converter(@d_shift))
    decrypted_message_array = []
    self.conversion_loop(index_array, decrypted_message_array, soup, decryption_hash)
  end
end
