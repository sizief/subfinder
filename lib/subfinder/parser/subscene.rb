require 'nokogiri'
require 'open-uri'

module Subfinder
  module Parser
    class Subscene

      attr_reader :link

      def initialize file_name
        @file_name = file_name
      end

      def run
        target_link = find_link(create_links_list(open(Config.url)))
        download target_link
      end

      def successful_download
        false
      end

      def find_link links
        max_match_point = 0
        winner = ''

        links.each do |link|
          next if link[0] != Config.language
          match_point = match_point_for link[1]
          if match_point > max_match_point
            max_match_point = match_point
            winner = link[2]
          end
        end
        winner
      end

      def match_point_for target
        point = 0
        file_name_array = @file_name.split(".")
        #next we want to know if name of the sub is seprataed by . or space
        target_array = target.split(".").size > target.split(" ").size ? target.split(".") : target.split(" ")

        file_name_array.each do |word|
          point +=1 if target_array.include? word
        end
        (point*100)/file_name_array.size
      end

      def create_links_list page
        array = Array.new
        doc = Nokogiri::HTML(page)
        doc.xpath('//table//tr').each do |link|
          next if link.xpath('./td/a/span/text()')[0].nil? #language
          array << [convert_to_code(link.xpath('./td/a/span/text()')[0].to_s.strip), #language
                    link.xpath('./td/a/span/text()')[1].to_s.strip, #name
                    link.xpath('./td/a/@href')[0].to_s.strip] #link
        end
        array
      end

      def convert_to_code language
        case language
        when 'Farsi/Persian'
          'fa'
        when 'English'
          'en'
        else
          language
        end
         #TODO: add other languages codes 
      end

      
     
    end
  end
end
