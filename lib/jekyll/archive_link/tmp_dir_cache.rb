# frozen_string_literal: true

require "json"
require "fileutils"
module Jekyll
  module ArchiveLink
    class TmpDirCache
      TMP_DIR = "./tmp/jekyll-archive-link/cache"

      def read(url)
        key = cache_key(url)
        path = path_for_file_with_key(key)
        if File.exist?(path)
          Jekyll::ArchiveLink.debug "HIT: Cache read #{url}"
          JSON.parse File.read(path)
        else
          Jekyll::ArchiveLink.debug "MISS: Cache read #{url}"
          nil
        end
      end

      def write(url, value)
        Jekyll::ArchiveLink.debug "Cache write: #{url}, value: #{value}"
        key = cache_key(url)
        path = path_for_file_with_key(key)
        FileUtils.mkdir_p(TMP_DIR) unless Dir.exist?(TMP_DIR)
        File.open(path, "wb") { |file| file.write(value) }
      end

      def delete(url)
        key = cache_key(url)
        path = path_for_file_with_key(key)
        FileUtils.rm(path)
      end

      private

      def cache_key(url)
        Digest::MD5.hexdigest(url)
      end

      def path_for_file_with_key(key)
        Pathname.new("#{TMP_DIR}/#{key}")
      end
    end
  end
end
