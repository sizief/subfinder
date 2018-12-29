module Subfinder
  module Parser
    class Files
      class << self
        def list
          prepare_file_list
          Dir["#{Config.working_dir}/*"]
        end

        def prepare_file_list
          files = Dir["#{Config.working_dir}/*"]
          compressed_files = files.select { |file| ['.zip', '.rar'].include? File.extname(file) }
          extract_all compressed_files
          move_compressed_files compressed_files
        end

        def extract_all(array_list)
          array_list.each do |file|
            Zip::File.open(file) do |zip_file|
              zip_file.each do |entry|
                file_path = Config.working_dir + '/' + entry.name
                unless File.exist? file_path
                  Logger.info "Extracting #{entry.name}"
                  entry.extract(file_path)
                end
              end
            end
          end
        end

        def move_compressed_files(compressed_files)
          unless compressed_files.empty?
            Dir.mkdir(Config.working_dir + '/compressed') unless File.exist?(Config.working_dir + '/compressed')
            compressed_files.each { |f| File.rename(f, File.dirname(f) + '/compressed/' + File.basename(f)) }
          end
        end
      end
    end
  end
end
