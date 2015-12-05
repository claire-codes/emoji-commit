require 'spec_helper'


# describe EmojiCommit do
#   it 'has a version number' do
#     expect(VERSION).not_to be nil
#   end
# end

# describe 'emoji_exists?' do
#   it 'will return true if it finds an emoji' do
#     expect(Emoji_Commit.emoji_exists?(':foo: bar')).to be true
#   end

#   it 'will return false if it doesn\'t find an emoji' do
#     expect(Emoji_Commit.emoji_exists?('floop')).to be false
#   end
# end

describe EmojiCommit::EmojiCommitMsg do

	describe '::edit_commit_msg' do
		test_file = 'test.txt'

		before(:each) do
			File.open(test_file, 'w')  {|f| f.write('foo bar') }
		end

		it 'will add an emoji to a commit message and write it to the file' do
			allow_any_instance_of(EmojiCommit::EmojiCommitMsg).to receive(:get_emoji).and_return(':foo:')
			emoji_commit = EmojiCommit::EmojiCommitMsg.new test_file
			emoji_commit.edit_commit_msg
			final_msg = File.open(test_file, 'r') { |f| f.read }
			expect(final_msg).to eq ':foo: foo bar'
		end

		it 'won\'t add a new emoji to a message that already starts with one' do
			File.open(test_file, 'w')  {|f| f.write(':rar: foo bar') }
			emoji_commit = EmojiCommit::EmojiCommitMsg.new test_file
			emoji_commit.edit_commit_msg
			final_msg = File.open(test_file, 'r') { |f| f.read }
			expect(final_msg).to eq ':rar: foo bar'
		end

		describe '::emoji_exists?' do

		end
	end
end