# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Issuers::AssetPrinter do
  subject(:asset_printer_writer) { described_class.new }
  let(:asset_printer_file) { './spec/fixtures/test.dot' }
  let(:map) { SimpleCrawler::Map.new }
  let(:location) { 'http://andre.com' }
  let(:links) { ['http://andre.com/taco'] }
  let(:inputs) { ['<input name="input-id">'] }
  let(:assets) { ['http://andre.com/style.css'] }

  let(:page) do
    page = double
    allow(page).to receive(:location).and_return(location)
    allow(page).to receive(:links).and_return(links)
    allow(page).to receive(:inputs).and_return(inputs)
    allow(page).to receive(:assets).and_return(assets)

    page
  end

  describe '#write' do
    after do
      File.unlink asset_printer_file
    end

    it 'writes a asset_printer file to the specified file' do
      map.add page
      asset_printer_writer.write(map, asset_printer_file)

      expect(File.exist?(asset_printer_file)).to be true
    end

    it 'writes the links to the asset_printer_file' do
      map.add page
      asset_printer_writer.write(map, asset_printer_file)
      expect(File.read(asset_printer_file)).to include "\"#{location}\" -> \"#{links[0]}\";"
    end
  end
end
