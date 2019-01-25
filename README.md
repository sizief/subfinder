[![CircleCI](https://circleci.com/gh/sizief/subfinder.svg?style=svg)](https://circleci.com/gh/sizief/subfinder) [![Maintainability](https://api.codeclimate.com/v1/badges/847c36c4319bef81de03/maintainability)](https://codeclimate.com/github/sizief/subfinder/maintainability)

# Tips for writing article about this gem
- Using VCR for testing 



# Subfinder
You have a TV series without subtitles. Open the terminal, go to the folder where you saved your files, and run `subfinder`. It will find the similar subtitle files on the folder and rename it to video file plus `.srt`. If the subtitles are not exists on your disk, then it will download, extract and rename from the `subscene` url you provided. 
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

`$ subfinder --url https://subscene.com/subtitles/the-kominsky-method -l fa`  

## How to development test

Clone the project. Make changes and then `rake build` inside the project folder to create Gem.
Then `gem install pkg/subfinder-0.0.1.gem` to install it locally. 
Create a temp folder and run `movies_list_creator.rb` inside that folder. It will create fake files.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


# TODO
- [x] get sub title language 
- [x] extarct all files
- [x] list all files
- [x] match srt for each video file
- [x] rename all amtches
- [x] move all other files to extar folder
- [x] if not available then find it online test
- [x] if not available then find it online code
- [x] if language sub is not available then find english
- [x] download match subtitle
- [x] check for internet connectivity or issue for accessing blocked websites
- [ ] move all other files from sub folders to main folder when extracting
- [ ] add all language codes
- [ ] add messages for timeout on web browsing
- [ ] save user entered config for later use
