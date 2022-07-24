# frozen_string_literal: true

require "rspec"
require "webmock/rspec"

RSpec.describe Jekyll::ArchiveLink::URL do
  describe "#latest_archive_url" do
    context "when url string is empty" do
      it "returns a blank String" do
        url = Jekyll::ArchiveLink::URL.new("")

        expect(url.latest_archive_url).to be_empty
      end
    end
    context "when url string is an invalid URL" do
      it "raises an exception" do
        url = Jekyll::ArchiveLink::URL.new("not-a-url@example.com")

        expect do
          url.latest_archive_url
        end.to raise_error(Jekyll::ArchiveLink::InvalidURL)
      end
    end
    context "when url string is already archived" do
      it "returns the original String" do
        url_string = "https://web.archive.org/already-archived"
        url = Jekyll::ArchiveLink::URL.new(url_string)

        expect(url.latest_archive_url).to be(url_string)
      end
    end
    context "when URL is a valid, archiveable URL" do
      it "returns the archived version from archive.org" do
        url_string = "https://gavinmorrice.com"
        request_string = "https://archive.org/wayback/available?url=#{url_string}"
        target_value = "https://web.archive.org/archived-url"

        stub_request(:get, request_string)
          .with(
            headers: {
              "Accept" => "*/*",
              "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "User-Agent" => "Faraday v2.3.0"
            }
          )
          .to_return(status: 200, body: "{}", headers: {
                       "memento-location": target_value
                     })
        url = Jekyll::ArchiveLink::URL.new(url_string)

        expect(url.latest_archive_url).to eql(target_value)
      end
    end
  end
end
