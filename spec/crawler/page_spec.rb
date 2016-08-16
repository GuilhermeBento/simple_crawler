# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Page do
  subject(:page) { described_class.new('http://www.google.com/pages') }

  let(:hrefs) do
    %w(http://www.google.com/page.html /one/level/down one/level/from/here)
  end

  let(:inputs) { ['<input name="input-name">', '<input name="input-name">'] }

  let(:assets) do
    %w(layout.css http://www.example.com/logo.jpg)
  end

  before do
    @response_double = double
    @faraday_double = instance_double(Faraday::Connection)
    allow(Faraday).to receive(:new).and_return(@faraday_double)
    allow(@faraday_double).to receive(:get).and_return(@response_double)
    allow(@response_double).to receive(:body).and_return('body')
    allow(@response_double).to receive(:status).and_return(200)
  end

  describe '#initialize' do
    it 'retrieves the page content' do
      expect(page.content).to eq 'body'
    end

    it 'sets the HTTP response on the page object' do
      expect(page.response_code).to eq 200
    end
  end

  describe '#links' do
    before do
      processor = instance_double(SimpleCrawler::PageProcessor)
      allow(processor).to receive(:links_in).and_return(hrefs)
      allow(processor).to receive(:inputs_in).and_return(inputs)
      allow(SimpleCrawler::PageProcessor).to receive(:new).and_return(processor)
    end

    it 'returns all the links in the page' do
      links = page.links

      expect(links.length).to eq 3
    end

    it 'returns all inputs in the page' do
      inputs = page.inputs
      expect(inputs.length).to eq 2
    end

    it 'removes nils from the links list' do
      hrefs << nil
      links = page.links

      expect(links.length).to eq 3
    end
  end

  describe '#assets' do
    before do
      processor = instance_double(SimpleCrawler::PageProcessor)
      allow(processor).to receive(:assets_in).and_return(assets)
      allow(SimpleCrawler::PageProcessor).to receive(:new).and_return(processor)
    end

    it 'returns all the assets in the page' do
      assets = page.assets
      expect(assets.length).to eq 2
    end
  end
end
