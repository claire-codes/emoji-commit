# EmojiCommit

Have you ever found your Git commit messages a little ... boring? Well they are. Just look at them! Now you can spice them up with :curry::banana::bomb: everyone's favourite characters: emojis!

## :wrench: Installation

Install on the command line with:

    $ gem install emoji-commit

## Usage :floppy_disk:

The gem installs a special commit hook script in a repo of your choosing.

Make sure you're in the root directory of a Git initialised repo (it will have the `.git` hidden folder in it, check it's there with `ls -a`). Then execute:

    $ emoji install

It will prompt to confirm you want to install, hit `y`. Now every time you write a commit message, a random emoji from [this](http://www.emoji-cheat-sheet.com/) list will be prefixed to it.

    $ git commit -m 'Some boring message'

Will be added to your repo as:

    :kimono: Some boring message

:kimono: Some boring message

Or:

    :sheep: Some boring message

:sheep: Some boring message

Or even:

    :lock_with_ink_pen: Some boring message

:lock_with_ink_pen: Some boring message

It is random after all.

If your message already begins with an emoji in the format `:foobar:` then this won't be overwritten. 

## :books: Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## :bug: Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/claireparker/emoji-commit.

## :lock: License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## :crystal_ball: Meta

On Ruby gems: [emoji-commit](https://rubygems.org/gems/emoji-commit)

