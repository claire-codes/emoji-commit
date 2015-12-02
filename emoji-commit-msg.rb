#!/usr/bin/ruby
require 'json'

msg_file = ARGV[0]

msg = File.read(msg_file)

emojis_file = File.read("#{File.dirname(__FILE__)}/emojis.json")
emojis_hash = JSON.parse(emojis_file)
emoji = emojis_hash[emojis_hash.keys.sample]

emoji_msg = "#{emoji} #{msg}"
File.open(msg_file, 'w') { |file| file.write(emoji_msg) }
