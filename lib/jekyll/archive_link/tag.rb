# frozen_string_literal: true

module Jekyll
  module ArchiveLink
    require "liquid"
    require_relative "url"
    class Tag < Liquid::Block
      attr_reader :link_text, :url

      def initialize(tag_name, link_text, tokens)
        super
        @link_text = link_text
      end

      def render(context)
        @url = super(context).to_s.strip
        Jekyll::ArchiveLink.debug("Render called: #{@url}")

        %[<a href="#{archive_url}">#{link_text}</a>]
      end

      def archive_url
        Jekyll::ArchiveLink.debug("archive_url: #{@url}")

        URL.new(url).latest_archive_url
      end
    end
  end
end

Liquid::Template.register_tag("archive_url_link", Jekyll::ArchiveLink::Tag)
