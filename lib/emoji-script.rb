#!/usr/bin/ruby
require 'emoji-commit-msg'

EmojiCommit::EmojiCommitMsg.new(ARGV[0]).edit_commit_msg
