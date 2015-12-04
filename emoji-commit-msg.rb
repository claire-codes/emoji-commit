#!/usr/bin/ruby
require 'json'

class Emoji_Commit

  attr_accessor :msg_file, :commit_msg

  def initialize(file)
    @commit_msg = File.read(file.to_s)
    @msg_file = File.open(file, 'a')
    puts @commit_msg
    #
  end

  def emoji_exists?(message)
    message.match(/^:(-|e-\w+)?(\w+):/) ? true : false
  end

  def get_emoji
    emojis_file = File.read("#{File.dirname(__FILE__)}/emojis.json")
    emojis_hash = JSON.parse(emojis_file)
    emojis_hash[emojis_hash.keys.sample].strip
  end

  def edit_commit_msg
    # msg_file = @file

    # commit_msg = File.read(@msg_file)

    unless emoji_exists?(commit_msg)

      @msg_file.puts "#{get_emoji} #{commit_msg}"
      # File.open(msg_file, 'w') { |file| file.write(emoji_msg) }

    end

    # commit_msg.close
  end

end

bar = ARGV[0].to_s

foo = Emoji_Commit.new bar
foo.edit_commit_msg
