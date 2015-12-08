#!/usr/bin/ruby
require 'emoji-commit-msg'

EmojiCommit::Msg.new(ARGV[0]).edit_commit_msg
