# frozen_string_literal: true

module Subfinder
  module Parser
    # All file and folder related actions
    class Files
      class << self
        def list
          prepare_file_list
          Dir["#{pwd}/*"]
        end

        def prepare_file_list
          files = Dir["#{pwd}/*"]
          compressed_files = files.select do |file|
            ['.zip', '.rar'].include? File.extname(file)
          end
          extract_all compressed_files
          move_compressed_files compressed_files
        end

        def extract_all(array_list)
          array_list.each do |file|
            Zip::File.open(file) do |zip_file|
              zip_file.each do |entry|
                file_path = pwd + '/' + entry.name
                unless File.exist? file_path
                  Logger.info "Extracting #{entry.name}"
                  entry.extract(file_path)
                end
              end
            end
          end
        end

        def move_compressed_files(compressed_files)
          return if compressed_files.empty?

          Dir.mkdir("#{pwd}/compressed") unless File.exist?("#{pwd}/compressed")
          compressed_files.each do |f|
            File.rename(f, File.dirname(f) + '/compressed/' + File.basename(f))
          end
        end

        def pwd
          Config.working_dir
        end
      end
    end
  end
end
