require 'spec_helper'

describe EmojiCommit::Cli do
  describe '::install' do
    it 'will exit if there isn\'t a .git directory' do
      allow(Dir).to receive(:exist?).with('.git').and_return(false)
      allow(STDIN).to receive(:gets).and_return('y')
      expect do
        expect(EmojiCommit::Cli.new.install).to output('Git has not been initialised in this directory. Bye').to_stdout
      end.to raise_error(SystemExit)
    end
  end
end