[![CircleCI](https://circleci.com/gh/sizief/subfinder.svg?style=svg)](https://circleci.com/gh/sizief/subfinder) [![Maintainability](https://api.codeclimate.com/v1/badges/847c36c4319bef81de03/maintainability)](https://codeclimate.com/github/sizief/subfinder/maintainability)

# TODO
- [x] get sub title language 
- [x] extarct all files
- [x] list all files
- [x] match srt for each video file
- [x] rename all amtches
- [x] move all other files to extar folder
- [x] if not available then find it online test
- [ ] if not available then find it online code
- [ ] if language sub is not available then find english
- [ ] download match subtitle
- [ ] move all other files from sub folders to main folder when extracting
- [ ] add all lngauges codes



# Subfinder

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/subfinder`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'subfinder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subfinder

## Usage

TODO: Write usage instructions here
$ subfinder -l fa -u https://url.com

## How to development test

Clone the project. Make changes and then `rake build` inside the project folder to create Gem.
Then `gem install pkg/subfinder-0.0.1.gem` to install it locally. 
Create a temp folder and run `movies_list_creator.rb` inside that folder. It will create fake files.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


