# frozen_string_literal: true
module SimpleCrawler
  module Issuers
    # Present the input number per page
    class InputCounter
      def write(map, path)
        @text_file = File.new(path, 'w')
        add_pages(map.site)
        @text_file.close
      end

      private

      def add_pages(links)
        urls = links.keys
        add_page(urls.pop, links) until urls.empty?
      end

      # CHANGE THIS METHOD
      def add_page(page, links)
        links[page].each do |page_data|
          next if page_data[0] != :inputs
          @text_file.puts "\"#{page}\" -> \"#{page_data[1].inspect}"
        end
      end
    end
  end
end
