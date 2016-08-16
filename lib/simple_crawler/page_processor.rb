# frozen_string_literal: true
module SimpleCrawler
  # Processes data on Page content
  class PageProcessor
    attr_reader :base

    def initialize(base)
      @base = base
    end

    def inputs_in(content)
      Nokogiri::HTML(content).xpath('//input').count
    end

    def links_in(content)
      doc = Nokogiri::HTML content
      hrefs_from(doc.xpath('//a')).compact.delete_if(&:empty?)
    end

    def assets_in(content)
      doc = Nokogiri::HTML content
      assets = names_for(doc.xpath('//img') + doc.xpath('//script') + doc.xpath('//link'))

      assets.compact
    end

    private

    def hrefs_from(collection)
      collection.map do |anchor|
        anchor.attributes['href'].value if anchor.attributes.key? 'href'
      end
    end

    def names_for(asset_collection)
      asset_collection.map do |asset|
        if asset.attributes.key? 'src'
          asset.attributes['src'].value
        elsif asset.attributes.key? 'href'
          asset.attributes['href'].value
        end
      end
    end
  end
end
