require 'spec_helper'

describe EmojiCommit::Cli do
  describe '::install' do
    it 'will exit if there isn\'t a .git directory' do
      allow(Dir).to receive(:exist?).with('.git').and_return(false)
      expect do
        expect(EmojiCommit::Cli.new.install).to output('Git has not been initialised in this directory. Bye').to_stdout
      end.to raise_error(SystemExit)
    end

    it 'will exit if user types no' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('n')
      expect do
        expect(EmojiCommit::Cli.new.install).to output('Fine whatever. Bye').to_stdout
      end.to raise_error(SystemExit)
    end

    it 'will exit if user types something other than y or n' do
      allow(Dir).to receive(:exist?).with('.git').and_return(true)
      allow(STDIN).to receive(:gets).and_return('?$@*')
      expect do
        expect(EmojiCommit::Cli.new.install).to output('Pardon? Oh who cares. Bye').to_stdout
      end.to raise_error(SystemExit)
    end

  end
end