# frozen_string_literal: true

module Jekyll
  module ArchiveLink
    require "faraday"
    require "faraday-http-cache"
    require_relative "tmp_dir_cache"
    require_relative "invalid_url"

    class URL
      ARCHIVE_HOST = "https://web.archive.org"
      API_URI = "wayback/available?url=%<url>s"

      attr_reader :api_client, :url

      class << self
        API_BASE = "https://archive.org"
        def api_client
          @api_client ||= Faraday.new(API_BASE) do |config|
            config.request(:json)
            config.response(:json)
            config.response :logger, Jekyll::ArchiveLink.logger

            config.use :http_cache,
                       store: Jekyll::ArchiveLink::TmpDirCache.new,
                       serializer: JSON
          end
        end
      end

      def initialize(url, api_client: self.class.api_client)
        Jekyll::ArchiveLink.debug("Initialize URL with #{url}")
        @api_client = api_client
        @url = url
      end

      # rubocop:disable Metrics/MethodLength
      def latest_archive_url
        Jekyll::ArchiveLink.debug("latest_archive_url")
        if url.empty?
          Jekyll::ArchiveLink.debug("URL is blank")
          return ""
        end

        unless URI.parse(url).is_a?(URI::HTTP)
          raise InvalidURL, "#{url} doesn't look like an archiveable URL"
        end

        if url.start_with?(ARCHIVE_HOST)
          Jekyll::ArchiveLink.debug("URL is already an archive link: #{url}")
          return url
        end

        memento_location
      end
      # rubocop:enable Metrics/MethodLength

      private

      def response
        @response ||= api_client.get(format(API_URI, url: url))
      end

      def response_headers
        response.headers || Hash.new("")
      end

      def memento_location
        response_headers["memento-location"]
      end
    end
  end
end
