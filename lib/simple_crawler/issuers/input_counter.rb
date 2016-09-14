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

      # TODO CHANGE THIS METHOD ,improve presentation
      def add_page(page, links)
        links[page].each do |page_data|
          next if page_data[0] != :inputs
          @text_file.puts "\"#{page}\" -> \"#{page_data[1] + calc_input_amount(links, page)}"
        end
      end

      def calc_input_amount(links, page)
        return unless links[page] && links[page][:links]
        links[page][:links].map do |child_link|
          links[child_link][:inputs]if links[child_link]
        end.compact.inject(0, :+)
      end
    end
  end
end
