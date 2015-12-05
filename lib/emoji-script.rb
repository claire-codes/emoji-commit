#!/usr/bin/ruby
require 'emoji-commit-msg'

foo = Emoji_Commit.new ARGV[0]
foo.edit_commit_msg
