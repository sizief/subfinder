# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Subfinder
  module Parser
    class Subscene
      attr_reader :link
      DOMAIN = 'https://subscene.com'

      def initialize(file_name)
        @file_name = file_name
      end

      def get
        target_uri = find_link(create_links_list(open_online_document(Config.url)))
        Subfinder::Parser::Download.new(find_download_link(open_online_document(DOMAIN + target_uri))).save
      end

      def open_online_document(url)
        open url
      rescue StandardError => e
        Logger.info "Error when connecting to '#{url}'\n Error message: #{e}\n".red
        abort('Check your internet connection or VPN and try again')
      end

      def find_download_link(page)
        doc = Nokogiri::HTML(page)
        download_link = nil
        doc.css('.download').each do |link|
          download_link = link.xpath('./a/@href').to_s.strip # link
        end
        Logger.debug "download_link: #{download_link}"
        DOMAIN + download_link
      end

      def find_link(links)
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
        Logger.debug "winner is #{winner}"
        winner
      end

      def match_point_for(target)
        point = 0
        file_name_array = @file_name.split('.')
        # next we want to know if name of the sub is seprataed by . or space
        target_array = target.split('.').size > target.split(' ').size ? target.split('.') : target.split(' ')
        target_array = target_array.map(&:downcase)

        file_name_array.each do |word|
          point += 1 if target_array.include? word.downcase
        end
        (point * 100) / file_name_array.size
      end

      def create_links_list(page)
        array = []
        doc = Nokogiri::HTML(page)
        doc.xpath('//table//tr').each do |link|
          next if link.xpath('./td/a/span/text()')[0].nil? # language

          array << [convert_to_code(link.xpath('./td/a/span/text()')[0].to_s.strip), # language
                    link.xpath('./td/a/span/text()')[1].to_s.strip, # name
                    link.xpath('./td/a/@href')[0].to_s.strip] # link
        end
        Logger.debug "array_list: #{array}"
        array
      end

      def convert_to_code(language)
        case language
        when 'Farsi/Persian'
          'fa'
        when 'English'
          'en'
        else
          language
        end
        # TODO: add other languages codes
      end
    end
  end
end
