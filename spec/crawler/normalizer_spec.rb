# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Normalizer do
  subject(:normalizer) { described_class.new location }
  let(:location)       { 'http://www.google.com/pages/page.html' }

  describe '#url_for' do
    it "doesn't modify hrefs with the full URL" do
      url = normalizer.url_for 'http://www.bob.com'
      expect(url).to eq 'http://www.bob.com'
    end

    it 'builds a correct URL for an absolute path' do
      url = normalizer.url_for '/somewhere/else'

      expect(url).to eq 'http://www.google.com/somewhere/else'
    end

    it 'builds a correct URL for a relative path' do
      url = normalizer.url_for 'another/page'

      expect(url).to eq 'http://www.google.com/pages/another/page'
    end

    it "returns nil if the href can't be processed" do
      allow(URI).to receive(:join).and_raise(StandardError)
      url = normalizer.url_for 'another/page'

      expect(url).to be nil
    end
  end
end
