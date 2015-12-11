require 'spec_helper'
require 'fakefs/spec_helpers'

describe EmojiCommit::Cli do
  describe '::install' do
    xit 'is a happy path' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('y')
      expect{EmojiCommit::Cli.new.install}.to output(/Great, installing into .git\/hooks/).to_stdout
    end

    it 'will exit if there isn\'t a .git directory' do
      allow(Dir).to receive(:exist?).with('.git').and_return(false)
      expect {EmojiCommit::Cli.new.install}.to output(/Git has not been initialised in this directory. Bye/).to_stdout & raise_error(SystemExit)
    end

    it 'will exit if user types no' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('n')
      expect {EmojiCommit::Cli.new.install}.to output(/Fine whatever. Bye/).to_stdout & raise_error(SystemExit)
    end

    it 'will exit if user types something other than y or n' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('?$@*')
      expect{EmojiCommit::Cli.new.install}.to output(/Pardon\? Oh who cares. Bye/).to_stdout & raise_error(SystemExit)
    end
  end

  describe '::uninstall' do
    it 'will exit if there isn\'t a .git directory' do
      allow(Dir).to receive(:exist?).with('.git').and_return(false)
      expect{EmojiCommit::Cli.new.uninstall}.to output(/Git has not been initialised in this directory. Bye/).to_stdout & raise_error(SystemExit)
    end

    it 'will exit if user types no' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('n')
      expect{EmojiCommit::Cli.new.uninstall}.to output(/Good choice. Bye/).to_stdout & raise_error(SystemExit)
    end

    it 'will exit if user types something other than y or n' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('?$@*')
      expect{EmojiCommit::Cli.new.uninstall}.to output(/Pardon\? Oh who cares. Bye/).to_stdout & raise_error(SystemExit)
    end
  end
end