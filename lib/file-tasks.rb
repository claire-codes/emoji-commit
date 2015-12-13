#!/usr/bin/env ruby
require 'fileutils'
require 'thor'

module EmojiCommit
  class Cli < Thor

    desc 'install', 'installs commit hook scripts'
    def install
      check_for_git
      
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

      filenames.each do |filename|
        FileUtils.cp("#{path}/#{filename}", ".git/hooks/#{filename}")
        FileUtils.chmod(0755, ".git/hooks/#{filename}")
      end
            
      puts 'Installed scripts successfully. Commit emoji-ful messages!'
    end

    desc 'uninstall', 'uninstalls commit hook scripts and restores sample script'
    def uninstall
      check_for_git

      puts 'You are about to uninstall the emoji Git commit hook'
      puts 'Is that OK? (y|n)'

      answer = STDIN.gets.strip.downcase

      if answer == 'n'
        puts 'Good choice. Bye'
        exit
      elsif answer != 'y'
        puts 'Pardon? Oh who cares. Bye'
        exit
      else
        puts 'As long as you\'re sure :( Removing files now'
      end

      filenames.each do |filename|
        FileUtils.rm(".git/hooks/#{filename}") if File.exists?(".git/hooks/#{filename}")
      end

      FileUtils.cp("#{path}/commit-msg.sample", ".git/hooks/commit-msg.sample") unless File.exist?('.git/hooks/commit-msg.sample')

      puts 'Uninstalled scripts successfully. Enjoy your boring emoji-less life.'
    end

    no_commands do
      def check_for_git
        unless Dir.exist?('.git')
          puts 'Git has not been initialised in this directory. Bye'
          exit
        end
      end

      def path
        File.dirname(File.expand_path(__FILE__))
      end

      def filenames
        ['emoji-script.rb', 'emoji-commit-msg.rb', 'commit-msg', 'emojis.json']
      end
    end
  end
end
