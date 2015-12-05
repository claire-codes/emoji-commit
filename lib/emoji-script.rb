#!/usr/bin/ruby
require 'emoji-commit-msg'

bar = ARGV[0]

foo = Emoji_Commit.new bar
foo.edit_commit_msg
