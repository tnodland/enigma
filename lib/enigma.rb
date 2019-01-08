require 'pry'
require './lib/alphabet_soup'
require './lib/key_maker'

class Enigma
  include KeyMaker

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

  def encrypt(message, key, date)
    encryption_hash = {encryption: "",
    key: key,
    date: date}
    self.key_converter(key)
    self.date_shifter(date)
    index_array = self.index_converter(message)
    encrypted_message_array = []
    soup = AlphabetSoup.new(@a_shift, @b_shift, @c_shift, @d_shift)

    loop do
      temp_letter_array = []

      if index_array.length >= 4
        letter_shifted_by_a = index_array.shift
        encrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        encrypted_message_array << soup.b_shift_array[letter_shifted_by_b]
        letter_shifted_by_c = index_array.shift
        encrypted_message_array << soup.c_shift_array[letter_shifted_by_c]
        letter_shifted_by_d = index_array.shift
        encrypted_message_array << soup.d_shift_array[letter_shifted_by_d]

      elsif index_array.length == 3
        letter_shifted_by_a = index_array.shift
        encrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        encrypted_message_array << soup.b_shift_array[letter_shifted_by_b]
        letter_shifted_by_c = index_array.shift
        encrypted_message_array << soup.c_shift_array[letter_shifted_by_c]
        letter_shifted_by_d = index_array.shift

      elsif index_array.length == 2
        letter_shifted_by_a = index_array.shift
        encrypted_message_array << soup.a_shift_array[letter_shifted_by_a]
        letter_shifted_by_b = index_array.shift
        encrypted_message_array << soup.b_shift_array[letter_shifted_by_b]

      elsif index_array.length == 1
        letter_shifted_by_a = index_array.shift
        encrypted_message_array << soup.a_shift_array[letter_shifted_by_a]

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
    @a_shift = @a_shift % 27 if @a_shift > 27
    @b_shift = @b_shift % 27 if @b_shift > 27
    @c_shift = @c_shift % 27 if @c_shift > 27
    @d_shift = @d_shift % 27 if @d_shift > 27

    decrypt_a_shift = 27 - @a_shift
    decrypt_b_shift = 27 - @b_shift
    decrypt_c_shift = 27 - @c_shift
    decrypt_d_shift = 27 - @d_shift

    index_array = self.index_converter(ciphertext)
    soup = AlphabetSoup.new(decrypt_a_shift, decrypt_b_shift, decrypt_c_shift, decrypt_d_shift)

    decrypted_message_array = []

    loop do
      temp_letter_array = []

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
