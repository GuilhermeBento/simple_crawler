# frozen_string_literal: true
module SimpleCrawler
  # Configurations class
  class Config
    attr_reader :boundary, :domain, :max_pages, :deep_levels
    def initialize(domain, subs = false, options = {})
      @domain = domain.sub(%r{^https?\://}, '').sub(/^www./, '')
      @max_pages = options.fetch(:max_pages, 50)
      @deep_levels = options.fetch(:deep_levels, 3)
      define_boundary(subs)
    end

    private

    def define_boundary(allow_subs)
      @boundary = allow_subs ? /^([\w-]*\.)*#{domain}$/ : /^#{domain}$/
    end
  end
end
