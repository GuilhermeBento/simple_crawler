# frozen_string_literal: true
module SimpleCrawler
  module Errors
    # Default url error class
    class InvalidUrl < StandardError
      attr_reader :object

      def initialize(url)
        super("The #{url} url is invalid")
        @object = url
      end
    end
    class UnknownFormat < StandardError; end
    class MaxPageReached < StandardError; end
    class InvalidDomain < StandardError; end
  end
end
