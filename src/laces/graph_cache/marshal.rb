module Laces
  module GraphCache
    # GraphCache cache-store implementation. This is the simplest of all stores
    # and simply marshals the Ruby objects into a flat-file. The methods below
    # are, for the most part, self-explanatory.
    class Marshal

      CACHE_FILE_NAME = 'graph.marshal.cache'

      def get
        return nil unless File.exist? cache_file
        ::Marshal.load(File.open(cache_file).read)
      end

      def store(graph)
        File.open(cache_file, 'w') do |f|
          dump = ::Marshal.dump(graph)
          f.write(dump)
        end
      end

      def init
        if !File.exist? cache_directory
          Dir.mkdir cache_directory
        else
          if !File.directory? cache_directory
            raise "ERROR::Cannot create cache directory #{{cache_directory}}"
          end
        end
      end

      private

      def cache_directory
        @cache_dir ||= Laces::settings.cache_directory
      end

      def cache_file
        @cache_file ||= File.join(cache_directory, CACHE_FILE_NAME)
      end

    end
  end
end