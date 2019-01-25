require 'rest-client'
module Subfinder
  module Parser
    class Download
      
      def self.save(_url)
        res = RestClient.get url
        return false if response_code_is_not_200? res
        file_name = res.headers[:content_disposition].split('=')[1]
        File.write("#{Dir.pwd}/#{file_name}", res.body)
        puts "- #{file_name} downloaded successfully!".colorize(:green)
        true
    end

    def self.response_code_is_not_200? res
      return false if res.code != 200
      return false if res.body.include? "An error occurred while processing your request."
    end

  end
end