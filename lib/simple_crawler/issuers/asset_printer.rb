# frozen_string_literal: true
module SimpleCrawler
  module Issuers
    # Prints assets and link per pages
    class AssetPrinter
      def write(map, path)
        @dot_file = File.new(path, 'w')
        add_pages(map.site)
        @dot_file.close
      end

      private

      def add_pages(links)
        @dot_file.puts 'digraph SiteMap {'
        urls = links.keys
        add_page(urls.pop, links) until urls.empty?
        @dot_file.puts '}'
      end

      def add_page(page, links)
        links[page][:links].each do |link|
          @dot_file.puts "\"#{page}\" -> \"#{link}\";"
        end
        add_page_assets(links[page][:assets])
      end

      def add_page_assets(assets)
        @dot_file.puts '========== Page assets =========='
        assets.each do |asset|
          @dot_file.puts "\"#{asset}\""
        end
        @dot_file.puts '================================='
      end
    end
  end
end
