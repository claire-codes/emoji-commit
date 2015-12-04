require 'FileUtils'
require 'Thor'

module EmojiCommit
	class Cli < Thor
		def install_commit_scripts
			unless Dir.exists?('.git') { exit }

			if File.exists?('.git/hooks/commit-msg') { FileUtils.rm('.git/hooks/commit-msg') }

			if File.exists?('.git/hooks/commit-msg.sample') { FileUtils.rm('.git/hooks/commit-msg.sample') }

			FileUtils.cp('emoji-script.rb', '.git/hooks/emoji-script.rb')
			FileUtils.cp('emoji-commit-msg.rb', '.git/hooks/emoji-commit-msg.rb')
			FileUtils.cp('commit-msg', '.git/hooks/commit-msg')
			FileUtils.cp('../assets/emojis.json', '.git/hooks/emojis.json')

		end
	end
end