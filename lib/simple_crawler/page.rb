# frozen_string_literal: true
module SimpleCrawler
  # Reference elements contained on a page
  class Page
    attr_reader :content, :location, :normalizer, :response_code

    def initialize(location)
      @normalizer = Normalizer.new(location)
      @location = location
      read_page
    end

    def links
      @links ||= Set.new filtered_links
    end

    def inputs
      @inputs ||= filtered_inputs
    end

    def assets
      @assets ||= processor.assets_in(@content)
    end

    private

    def read_page
      response = agent(base).get(path)
      @content = response.body
      @response_code = response.status
    end

    def agent(uri_base = nil)
      @agent ||= Faraday.new(url: uri_base, ssl: { verify: false }) do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects, limit: 10
        faraday.adapter Faraday.default_adapter
      end
    end

    def filtered_inputs
      processor.inputs_in(@content)
    end

    def filtered_links
      processor.links_in(@content).map { |href| normalizer.url_for href }.compact
    end

    def processor
      @processor ||= PageProcessor.new(base)
    end

    def base
      normalizer.base
    end

    def path
      normalizer.path
    end
  end
end
