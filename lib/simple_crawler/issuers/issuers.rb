# frozen_string_literal: true
module SimpleCrawler
  # Builder class
  module Issuers
    def self.new(format)
      issuers = const_get(constantize(format))
      issuers.new
    rescue NameError => e
      error = "Could not find an issuer for the #{format} format. #{e}"
      raise SimpleCrawler::Errors::UnknownFormat, error
    end

    private_class_method

    def self.constantize(format)
      format.to_s.split('_').map(&:capitalize).join('')
    end
  end
end
