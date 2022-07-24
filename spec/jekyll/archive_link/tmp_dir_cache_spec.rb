# frozen_string_literal: true

require "rspec"

RSpec.describe Jekyll::ArchiveLink::TmpDirCache do
  let(:cache) { described_class.new }
  before do
    FileUtils.rm_rf("./tmp/jekyll-archive_link/cache")
  end

  describe "#write" do
    it "creates a new file in the tmp directory" do
      expect do
        cache.write("cache_key", "{}")
      end.to change {
        Dir["./tmp/jekyll-archive_link/cache/*"].count
      }.by(1)
    end
  end

  describe "#read" do
    it "returns nil when item hasn't been cached" do
      expect(cache.read("cache_key")).to be_nil
    end

    it "returns cached JSON if available" do
      cache.write("cache_key", ' { "key": "value" } ')
      expect(cache.read("cache_key")).to eql({ "key" => "value" })
    end
  end

  describe "#delete" do
    it "deletes the cached value" do
      cache.write("cache_key", {})
      cache.delete("cache_key")
      expect(cache.read("cache_key")).to be_nil
    end
  end
end
