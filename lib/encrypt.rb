require './lib/enigma'

message = File.read(ARGV[0])
encrypted_file = File.open(ARGV[1], "w")

enigma = Enigma.new

encrypted_message = enigma.encrypt(message)
encrypted_file.write(encrypted_message[:encryption])
puts "Created '#{ARGV[1]}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}."
