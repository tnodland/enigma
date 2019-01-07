require 'pry'
require './lib/alphabet_soup'

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
    message = message.downcase
    encrypted_message_array = []
    message_array = message.split ""
    soup = AlphabetSoup.new(@a_shift, @b_shift, @c_shift, @d_shift)

    loop do
      temp_letter_array = []

      if message_array.length >= 4
        letter_shifted_by_a = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@a_shift).first

        letter_shifted_by_b = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@b_shift).first

        letter_shifted_by_c = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_c == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@c_shift).first

        letter_shifted_by_d = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_d == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@d_shift).first

      elsif message_array.length == 3
        letter_shifted_by_a = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@a_shift).first

        letter_shifted_by_b = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@b_shift).first

        letter_shifted_by_c = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_c == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@c_shift).first

      elsif message_array.length == 2
        letter_shifted_by_a = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@a_shift).first

        letter_shifted_by_b = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@b_shift).first

      elsif message_array.length == 1
        letter_shifted_by_a = message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        encrypted_message_array << temp_letter_array.rotate(@a_shift).first

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

    ciphertext = ciphertext.downcase
    decrypted_message_array = []
    ciphertext_message_array = ciphertext.split ""

    loop do
      temp_letter_array = []

      if ciphertext_message_array.length >= 4
        letter_shifted_by_a = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_a_shift).first

        letter_shifted_by_b = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_b_shift).first

        letter_shifted_by_c = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_c == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_c_shift).first

        letter_shifted_by_d = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_d == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_d_shift).first

      elsif ciphertext_message_array.length == 3
        letter_shifted_by_a = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_a_shift).first

        letter_shifted_by_b = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_b_shift).first

        letter_shifted_by_c = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_c == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_c_shift).first

      elsif ciphertext_message_array.length == 2
        letter_shifted_by_a = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_a_shift).first

        letter_shifted_by_b = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_b == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_b_shift).first

      elsif ciphertext_message_array.length == 1
        letter_shifted_by_a = ciphertext_message_array.shift
          @letters.each do |letter|
            if letter_shifted_by_a == letter
              temp_letter_array = @letters.rotate(@letters.index(letter))
            end
          end
        decrypted_message_array << temp_letter_array.rotate(decrypt_a_shift).first

      else
        decryption_hash[:decryption] = decrypted_message_array.join
        return decryption_hash
      end
    end
  end
end
