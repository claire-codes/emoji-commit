require_relative '../emoji-commit-msg'
require 'spec_helper'

# def emoji_exists?(message)
#   message.match(/^:(-|e-\w+)?(\w+):/) ? true : false
# end

describe 'emoji_exists?' do
  it 'will return true if it finds an emoji' do
    expect(Emoji_Commit.emoji_exists?(':foo: bar')).to be true
  end

  it 'will return false if it doesn\'t find an emoji' do
    expect(Emoji_Commit.emoji_exists?('floop')).to be false
  end
end
