# frozen_string_literal: true

module Jekyll
  module ArchiveLink
    require "liquid"
    require_relative "url"
    class Tag < Liquid::Block
      attr_reader :url

      def render(context)
        @url = super.to_s.strip
        Jekyll::ArchiveLink.debug("Render called: #{@url}")

        <<~HTML
          <a href="#{archive_url}">Archive link</a>
        HTML
      end

      def archive_url
        Jekyll::ArchiveLink.debug("archive_url: #{@url}")

        URL.new(url).latest_archive_url
      end
    end
  end
end

Liquid::Template.register_tag("archive_url_link", Jekyll::ArchiveLink::Tag)
