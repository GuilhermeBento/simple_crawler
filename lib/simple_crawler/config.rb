# frozen_string_literal: true
module SimpleCrawler
  # Configurations class
  class Config
    attr_reader :boundary, :domain, :max_page, :deep_levels
    def initialize(domain, subs = false, options = {})
      @domain = domain.sub(%r{^https?\://}, '').sub(/^www./, '')
      @max_page = options[:max_page]
      @deep_levels = options[:deep_levels]
      define_boundary(subs)
    end

    private

    def define_boundary(allow_subs)
      @boundary = allow_subs ? /^([\w-]*\.)*#{domain}$/ : /^#{domain}$/
    end
  end
end
