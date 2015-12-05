#!/usr/bin/ruby
require 'emoji-commit-msg'

EmojiCommit::Emoji_Commit.new(ARGV[0]).edit_commit_msg
