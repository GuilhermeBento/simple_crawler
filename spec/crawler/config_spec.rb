# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Config do
  subject(:config) { described_class.new('test.com') }

  describe '#initialize' do
    it 'sets the domain boundary' do
      expect('test.com').to match config.boundary
    end

    it 'doesn`t allow subdomains if not specified' do
      expect('sub.test.com').not_to match config.boundary
    end

    it 'allows subdomains if specified' do
      allow_subs = described_class.new('test.com', true)
      expect('sub.test.com').to match allow_subs.boundary
    end
  end
end
