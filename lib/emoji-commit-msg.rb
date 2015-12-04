#!/usr/bin/ruby
require 'json'

class Emoji_Commit

  attr_accessor :msg_file

  def initialize(file)
    @msg_file = file
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
    commit_msg = File.read(@msg_file)
    unless emoji_exists?(commit_msg)
      File.write(@msg_file, "#{get_emoji} #{commit_msg}")
    end
  end

end

# bar = ARGV[0]

# foo = Emoji_Commit.new bar
# foo.edit_commit_msg

