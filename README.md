
[![CircleCI](https://circleci.com/gh/sizief/subfinder.svg?style=svg)](https://circleci.com/gh/sizief/subfinder) [![Maintainability](https://api.codeclimate.com/v1/badges/847c36c4319bef81de03/maintainability)](https://codeclimate.com/github/sizief/subfinder/maintainability)

  

# Subfinder

You have a TV series without subtitles. Open the terminal, go to the folder where you saved your files, and run `subfinder`. It will find the similar subtitle files (only `.srt`) on the folder and rename it to video file. If the subtitles are not exists on your disk, then it will download, from the `subscene` URL you provided, extract and rename them.

It works fine with the video file names which followed `S01E01` naming format.

## Installation

  

First you need to have `Ruby` and `Gem` on your machine.

  

Then simply run:

  

`$ gem install subfinder`

  

## Usage

  

`$ subfinder -u https://subscene.com/subtitles/the-kominsky-method -l fa`

- Use `-l` or `--language`for subtitle language you want. Default is English.

- Use `-u` or `--url` to specify a URL page of a TV series on `subscene.com` website.

  
  

## Development

  

To run tests, run `rake test`.

  
  

Clone the project. Make changes and then `rake build` inside the project folder to create Gem.

Then `gem install pkg/subfinder-0.0.1.gem` to install it locally.

Create a temp folder and run `movies_list_creator.rb` inside that folder. It will create fake files.

Use following script to create a list_file of current episodes in any folder

```ruby -e'Dir["#{Dir.pwd}/*"].each{ |file| File.open("#{Dir.pwd}/files_list.txt", "a") { |f| f.write(file.split("/").last+"\n") }}'```

  
  

## License

  

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

  
  

# TODO

- [x] get sub title language

- [x] extract all files

- [x] list all files

- [x] match srt for each video file

- [x] rename all matches

- [x] move all other files to extract folder

- [x] if not available then find it online test

- [x] if not available then find it online code

- [x] if language sub is not available then find English

- [x] download match subtitle

- [x] check for internet connectivity or issue for accessing blocked websites

- [ ] move all other files from sub folders to main folder when extracting

- [ ] add all language codes

- [ ] add messages for timeout on web browsing

- [ ] save user entered config for later use

- [ ] Writing article about it (VCR)
