# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Map do
  subject(:site_map) { described_class.new }
  let(:url) { 'https://www.google.com' }

  let(:links) do
    %w(http://www.google.com/fake/path http://www.google.com/another/fake/path)
  end

  let(:inputs) { ['<input name="input-name">', '<input name="input-name">'] }

  let(:assets) do
    %w(styles.css behaviors.js link_stuff)
  end

  let(:page) do
    page = double

    allow(page).to receive(:location).and_return(url)
    allow(page).to receive(:links).and_return(links)
    allow(page).to receive(:inputs).and_return(inputs)
    allow(page).to receive(:assets).and_return(assets)
    page
  end

  describe '#add' do
    before do
      site_map.add page
    end

    it 'adds the pages links' do
      page_record = site_map.site[url]
      expect(page_record[:links].to_a).to eq links
    end

    it 'adds the page inputs' do
      page_record = site_map.site[url]
      expect(page_record[:inputs].to_a).to eq inputs
    end

    xit 'adds the assets to the static_assets collection' do
      expect(site_map.static_assets).to include 'styles.css', 'behaviors.js'
    end
  end
end
