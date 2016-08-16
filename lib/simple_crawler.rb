# frozen_string_literal: true
require 'nokogiri'
require 'faraday'
require 'faraday_middleware'
require 'set'

require_relative 'simple_crawler/version'
require_relative 'simple_crawler/errors/errors.rb'
require_relative 'simple_crawler/config.rb'
require_relative 'simple_crawler/page.rb'
require_relative 'simple_crawler/page_processor.rb'
require_relative 'simple_crawler/normalizer.rb'
require_relative 'simple_crawler/map.rb'
require_relative 'simple_crawler/issuers/issuers.rb'
require_relative 'simple_crawler/issuers/input_counter.rb'
require_relative 'simple_crawler/issuers/asset_printer.rb'

# Main  module
module SimpleCrawler
  # Main class, provides the interface
  class Mapper
    attr_reader :map, :config

    def initialize(domain, sub, *options)
      @config = SimpleCrawler::Config.new(domain, sub, *options)
      @map = SimpleCrawler::Map.new
    end

    def crawl
      links = Set.new [validate_url('http://www.' + @config.domain)]
      until links.empty?
        links = links.merge(follow_link(links.first) || [])
        links = links.delete(links.first)
      end
    end

    def data_issuer(issuer_type, path)
      issuer = SimpleCrawler::Issuers.new(issuer_type)
      issuer.write(map, path)
    end

    private

    def follow_link(location)
      page = SimpleCrawler::Page.new(location)
      visited << location
      return unless page.response_code == 200
      save_page page
      filter_external_domains(page.links.to_a) - visited
    end

    def save_page(page)
      map.add page
    end

    def filter_external_domains(found_links)
      (found_links || []).select { |link| URI.parse(link).host.to_s.match config.boundary }
    end

    def visited
      @visited ||= []
    end

    def validate_url(url)
      raise SimpleCrawler::Errors::InvalidUrl.new(url) unless url =~ URI.regexp
      url
    end
  end
end