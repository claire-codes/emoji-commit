require 'spec_helper'

# def emoji_exists?(message)
#   message.match(/^:(-|e-\w+)?(\w+):/) ? true : false
# end

# describe 'emoji_exists?' do
#   it 'will return true if it finds an emoji' do
#     expect(Emoji_Commit.emoji_exists?(':foo: bar')).to be true
#   end

#   it 'will return false if it doesn\'t find an emoji' do
#     expect(Emoji_Commit.emoji_exists?('floop')).to be false
#   end
# end

describe 'whole process' do
	test_file = 'test.txt'

	before(:each) do
		File.open(test_file, 'w')  {|f| f.write('foo bar') }
	end

	it 'will add an emoji to a commit message and write it to the file' do
		allow_any_instance_of(Emoji_Commit).to receive(:get_emoji).and_return(':foo:')
		emoji_commit = Emoji_Commit.new test_file
		emoji_commit.edit_commit_msg
		final_msg = File.open(test_file, 'r') { |f| f.read }
		expect(final_msg).to eq ':foo: foo bar'
	end

	it 'won\'t add a new emoji to a message that already starts with one' do
		File.open(test_file, 'w')  {|f| f.write(':rar: foo bar') }
		emoji_commit = Emoji_Commit.new test_file
		emoji_commit.edit_commit_msg
		final_msg = File.open(test_file, 'r') { |f| f.read }
		expect(final_msg).to eq ':rar: foo bar'
	end
end