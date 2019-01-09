require_relative 'enigma'

encrypted_message = File.read(ARGV[0])
decrypted_file = File.open(ARGV[1], "w")
enigma = Enigma.new

decrypted_message = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])

decrypted_file.write(decrypted_message[:decryption])

puts "Created #{ARGV[1]} with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}."
