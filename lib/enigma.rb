require 'pry'
require './lib/alphabet_soup'
require './lib/key_maker'
require './lib/shifter'

class Enigma
  include KeyMaker
  include Shifter

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
        if message_letter == letter
          index_array << @letters.index(letter)
        end
      end
    end
    index_array
  end

  def encrypt(message, key = make_key, date = Time.now.strftime("%d%m%Y"))
    encryption_hash = {encryption: "",
    key: key,
    date: date}
    self.key_converter(key)
    self.date_shifter(date)
    index_array = self.index_converter(message)
    encrypted_message_array = []
    soup = AlphabetSoup.new(@a_shift, @b_shift, @c_shift, @d_shift)

    loop do
      if index_array.length >= 4
        self.shift_applier(index_array, encrypted_message_array, soup.a_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.b_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.c_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.d_shift_array)
      elsif index_array.length == 3
        self.shift_applier(index_array, encrypted_message_array, soup.a_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.b_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.c_shift_array)
      elsif index_array.length == 2
        self.shift_applier(index_array, encrypted_message_array, soup.a_shift_array)
        self.shift_applier(index_array, encrypted_message_array, soup.b_shift_array)
      elsif index_array.length == 1
        self.shift_applier(index_array, encrypted_message_array, soup.a_shift_array)
      else
        encryption_hash[:encryption] = encrypted_message_array.join
        return encryption_hash
      end
    end
  end

  def decrypt(ciphertext, key, date)
    decryption_hash = {decryption: "",
    key: key,
    date: date}
    self.key_converter(key)
    self.date_shifter(date)

    decrypt_a_shift = self.shift_converter(@a_shift)
    decrypt_b_shift = self.shift_converter(@b_shift)
    decrypt_c_shift = self.shift_converter(@c_shift)
    decrypt_d_shift = self.shift_converter(@d_shift)

    index_array = self.index_converter(ciphertext)
    soup = AlphabetSoup.new(decrypt_a_shift, decrypt_b_shift, decrypt_c_shift, decrypt_d_shift)

    decrypted_message_array = []

    loop do
      if index_array.length >= 4
        letter_shifted_by_a = index_array.shift
        decrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        decrypted_message_array << soup.b_shift_array[letter_shifted_by_b]
        letter_shifted_by_c = index_array.shift
        decrypted_message_array << soup.c_shift_array[letter_shifted_by_c]
        letter_shifted_by_d = index_array.shift
        decrypted_message_array << soup.d_shift_array[letter_shifted_by_d]

      elsif index_array.length == 3
        letter_shifted_by_a = index_array.shift
        decrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        decrypted_message_array << soup.b_shift_array[letter_shifted_by_b]
        letter_shifted_by_c = index_array.shift
        decrypted_message_array << soup.c_shift_array[letter_shifted_by_c]
        letter_shifted_by_d = index_array.shift

      elsif index_array.length == 2
        letter_shifted_by_a = index_array.shift
        decrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        decrypted_message_array << soup.b_shift_array[letter_shifted_by_b]

      elsif index_array.length == 1
        letter_shifted_by_a = index_array.shift
        decrypted_message_array << soup.a_shift_array[letter_shifted_by_a]

      else
        decryption_hash[:decryption] = decrypted_message_array.join
        return decryption_hash
      end
    end
  end
end
