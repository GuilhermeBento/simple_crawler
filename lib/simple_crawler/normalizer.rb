# frozen_string_literal: true
require 'uri'

module SimpleCrawler
  # Normalizer functions for url
  class Normalizer
    attr_reader :location, :base, :path

    def initialize(location)
      @location = URI.parse location
    end

    # TODO improve me
    def url_for(href)
      # return URI.parse(href).to_s unless href[0] == '/'
      URI.join(location, clean(href)).to_s
    rescue StandardError => e
      puts e
      nil # compact
    end

    def base
      "#{location.scheme}://#{location.host}"
    end

    def path
      location.path
    end

    private

    def clean(href)
      strip_fragment strip_query(to_ascii(href))
    end

    def strip_query(href)
      href.split('?').first || ''
    end

    def strip_fragment(href)
      href.split('#').first || ''
    end

    def to_ascii(text)
      text.encode('ascii', invalid: :replace, undef: :replace, replace: '')
    end
  end
end
