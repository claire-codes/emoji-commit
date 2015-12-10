#!/usr/bin/env ruby
require 'fileutils'
require 'thor'

module EmojiCommit
  class Cli < Thor
    desc 'install', 'installs commit hook scripts'

    def install
      unless Dir.exist?('.git')
        puts 'Git has not been initialised in this directory. Bye'
        exit
      end

      puts 'You are about to overwrite any existing Git commit hook with the emoji script'
      puts 'Is that OK? (y|n)'
      
      answer = STDIN.gets.strip.downcase
      
      if answer == 'n'
        puts 'Fine whatever. Bye'
        exit
      elsif answer != 'y'
        puts 'Pardon? Oh who cares. Bye'
        exit
      else
        puts 'Great, installing into .git/hooks'
      end

      if File.exist?('.git/hooks/commit-msg') then FileUtils.rm('.git/hooks/commit-msg') end
      if File.exist?('.git/hooks/commit-msg.sample') then FileUtils.rm('.git/hooks/commit-msg.sample') end

      # path = path_to_resources
      path = File.dirname(File.expand_path(__FILE__))    

      ['emoji-script.rb', 'emoji-commit-msg.rb', 'commit-msg', 'emojis.json'].each do |f|
        FileUtils.cp("#{path}/#{f}", ".git/hooks/#{f}")
      end
      
      FileUtils.chmod 0755, %w(.git/hooks/emoji-script.rb .git/hooks/emoji-commit-msg.rb .git/hooks/commit-msg .git/hooks/emojis.json)
      
      puts 'Installed scripts successfully. Commit emoji-ful messages!'
    end

    no_commands do
      def path_to_resources
        File.dirname(File.expand_path(__FILE__))
      end
    end
  end
end
