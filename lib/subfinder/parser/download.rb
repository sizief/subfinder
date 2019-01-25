require 'rest-client'
module Subfinder
  module Parser
    class Download
      def initialize url
        @url = url
      end

      def save 
        res = RestClient.get @url
        return false unless response_is_healthy? res

        file_name = res.headers[:content_disposition].split('=')[1]
        File.write("#{Config.working_dir}/#{file_name}", res.body)
        true
      rescue StandardError => e
        Logger.info "Error when downloading '#{@url}'\n Error message: #{e}\n".red
        false
      end

      def response_is_healthy?(res)
        if res.code != 200
          Logger.info "Error when downloading '#{@url}'\n Error message: resposnse code is #{res.code}\n".red
          return false 
        elsif res.body.include? 'An error occurred while processing your request.'
          Logger.info "Error when downloading '#{@url}'\n Error message:  'An error occurred while processing your request.'\n".red
          return false
        else
          return true
        end
      end
    end
  end
end
