require 'spec_helper'

describe EmojiCommit::Cli do
  xdescribe '::install' do
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
    before(:all) do
      puts 'making'
      FileUtils.mkdir('foo')
    end

    describe 'successful' do
      xit 'deletes hooks and replaces non-existent .sample' do
        allow(EmojiCommit::Cli).to receive(:path).and_return('foo/')
        allow(EmojiCommit::Cli).to receive(:filenames).and_return(['bar'])


      end

      it 'deletes hooks but .sample already exists' do
        allow(EmojiCommit::Cli).to receive(:path).and_return('foo/')
        allow(EmojiCommit::Cli).to receive(:filenames).and_return(['bar'])
        allow(File).to receive(:exist?).with('.git/hooks/commit-msg.sample').and_return(true)
        FileUtils.touch("foo/bar")
        expect(File.exists?('foo/bar')).to be true
        allow(Dir).to receive(:exist?).with('.git').and_return(true)
        allow(STDIN).to receive(:gets).and_return('y')
        expect{EmojiCommit::Cli.new.uninstall}.to output(/Uninstalled scripts successfully. Enjoy your boring emoji-less life./).to_stdout
        expect(File.exists?('foo/bar')).to be false
      end

      xit 'no hooks to delete and replaces non-existent .sample' do

      end

      xit 'no hooks to delete and .sample already exists' do
        allow(EmojiCommit::Cli).to receive(:path).and_return('foo/')
        allow(EmojiCommit::Cli).to receive(:filenames).and_return(['bar'])
        allow(File).to receive(:exist?).with('.git/hooks/commit-msg.sample').and_return(true)
        expect(File.exists?('foo/bar')).to be false
        allow(Dir).to receive(:exist?).with('.git').and_return(true)
        allow(STDIN).to receive(:gets).and_return('y')
        expect{EmojiCommit::Cli.new.uninstall}.to output(/Uninstalled scripts successfully. Enjoy your boring emoji-less life./).to_stdout
      end
    end
    

    describe 'don\'t get past prompt' do
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

    after(:all) do
      puts ' deleting'
      FileUtils.rm_rf('foo')
    end
  end
end