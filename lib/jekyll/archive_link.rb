# frozen_string_literal: true

require "forwardable"
require "jekyll"

require_relative "archive_link/version"
require_relative "archive_link/tag"
require_relative "archive_link/logger"

module Jekyll
  module ArchiveLink
    class << self
      LOG_DIR = "./log"
      LOGGER_PATH = Pathname.new("#{LOG_DIR}/jekyll-archive_link.log")
      extend Forwardable
      def_delegators :logger, :debug, :warn, :info

      def logger
        @logger ||= initialize_logger
      end

      private

      def initialize_logger
        FileUtils.mkdir_p(LOG_DIR)
        Jekyll::ArchiveLink::Logger.new(LOGGER_PATH, level: Jekyll.logger.level)
      end
    end
  end
end
