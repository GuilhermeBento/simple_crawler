# frozen_string_literal: true
module SimpleCrawler
  # Contains all site information on each page
  class Map
    attr_reader :site, :static_assets

    def initialize
      @site = {}
      @static_assets = Set.new
    end

    def add(page)
      site[page.location] = {
        inputs: page.inputs,
        links: Set.new(page.links),
        assets: Set.new(page.assets)
      }
      # TODO;  Prevent duplicates erase me
      # assets_index_for(page)
    end

    private

    def assets_index_for(page)
      page.assets.map do |asset|
        static_assets.add asset
        static_assets.find_index asset
      end
    end
  end
end
