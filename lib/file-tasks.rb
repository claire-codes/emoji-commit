require 'FileUtils'
require 'Thor'

module EmojiCommit
	class Cli < Thor
		desc 'install', 'installs commit hook scripts'

		def install
			exit unless Dir.exists?('.git')

			if File.exists?('.git/hooks/commit-msg') then FileUtils.rm('.git/hooks/commit-msg') end

			if File.exists?('.git/hooks/commit-msg.sample') then FileUtils.rm('.git/hooks/commit-msg.sample') end

			path = path_to_resources

			FileUtils.cp(path + '/emoji-script.rb', '.git/hooks/emoji-script.rb')
			FileUtils.cp(path + '/emoji-commit-msg.rb', '.git/hooks/emoji-commit-msg.rb')
			FileUtils.cp(path + '/commit-msg', '.git/hooks/commit-msg')
			FileUtils.cp(path + '/assets/emojis.json', '.git/hooks/emojis.json')
			puts 'Made it'

		end

		no_commands do
			def path_to_resources
				File.dirname(File.expand_path(__FILE__))
			end
		end			
	end
end