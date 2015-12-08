#!/usr/bin/ruby
require 'json'

module EmojiCommit
  class Msg
    attr_accessor :msg_file

    def initialize(file)
      @msg_file = file
    end

    def emoji_exists?(message)
      message.match(/^:(-|\+|non-|e-\w+)?(\w+):/) ? true : false
    end

    def get_emoji
      puts Dir.pwd

      emojis_file = File.read(path_to_emojis)
      emojis_hash = JSON.parse(emojis_file)
      emojis_hash[emojis_hash.keys.sample].strip
    end

    def path_to_emojis
      "#{Dir.pwd}/.git/hooks/emojis.json"
    end

    def edit_commit_msg
      commit_msg = File.read(@msg_file)
      return if emoji_exists?(commit_msg)
      File.write(@msg_file, "#{get_emoji} #{commit_msg}")
    end
  end
end
