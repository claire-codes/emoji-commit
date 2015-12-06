require 'spec_helper'
require 'json'

# describe EmojiCommit do
#   it 'has a version number' do
#     expect(VERSION).not_to be nil
#   end
# end


describe EmojiCommit::EmojiCommitMsg do
  test_file = 'test.txt'
  describe '::edit_commit_msg' do

    before(:each) do
      File.open(test_file, 'w') { |f| f.write('foo bar') }
    end

    it 'will add an emoji to a commit message and write it to the file' do
      allow_any_instance_of(EmojiCommit::EmojiCommitMsg).to receive(:get_emoji).and_return(':foo:')
      emoji_commit = EmojiCommit::EmojiCommitMsg.new test_file
      emoji_commit.edit_commit_msg
      final_msg = File.open(test_file, &:read)
      expect(final_msg).to eq ':foo: foo bar'
    end

    it 'won\'t add a new emoji to a message that already starts with one' do
      File.open(test_file, 'w') { |f| f.write(':rar: foo bar') }
      emoji_commit = EmojiCommit::EmojiCommitMsg.new test_file
      emoji_commit.edit_commit_msg
      final_msg = File.open(test_file, &:read)
      expect(final_msg).to eq ':rar: foo bar'
    end
  end

  describe '::emoji_exists?' do
    subject do
      EmojiCommit::EmojiCommitMsg.new(test_file)
    end

    it 'will return true if message begins with an emoji' do
      expect(subject.emoji_exists?(':foo: bar')).to be true
      expect(subject.emoji_exists?(':foo:bar')).to be true
      expect(subject.emoji_exists?(':foo::bar: bar')).to be true
      expect(subject.emoji_exists?(':foo:')).to be true
      expect(subject.emoji_exists?(':foo: ')).to be true
    end

    it 'will return false if msg doesn\'t start with an emoji' do
      expect(subject.emoji_exists?('floop')).to be false
      expect(subject.emoji_exists?(' :foo: floop')).to be false
      expect(subject.emoji_exists?('floop :foo:')).to be false
      expect(subject.emoji_exists?('')).to be false
      expect(subject.emoji_exists?(' ')).to be false
    end

    it 'the regex matches every emoji in the json' do
      emojis_file = File.read("#{Dir.pwd}/lib/assets/emojis.json")
      JSON.parse(emojis_file) do |k, emoji|
        puts emoji if subject.emoji_exists?(emoji) == false
        expect(subject.emoji_exists?(emoji)).to be true
      end
    end
  end

  describe '::get_emoji' do
    subject do
      EmojiCommit::EmojiCommitMsg.new(test_file)
    end

    it 'will return one emoji as defined by ::emoji_exists?' do
      allow_any_instance_of(EmojiCommit::EmojiCommitMsg).to receive(:path_to_emojis).and_return(File.expand_path("../test_data/emojis.json", __FILE__))
      expect(subject.get_emoji).to be_a(String)
      expect(subject.emoji_exists?(subject.get_emoji)).to be true
    end
  end
end
