# frozen_string_literal: true
require 'spec_helper'

describe SimpleCrawler::Issuers do
  subject(:issuer) { SimpleCrawler::Issuers }

  describe '#new' do
    it 'returns an instance of the specified issuer' do
      expect(issuer.new(:asset_printer)).to be_kind_of SimpleCrawler::Issuers::AssetPrinter
    end

    it 'returns an instance of the specified issuer' do
      expect(issuer.new(:input_counter)).to be_kind_of SimpleCrawler::Issuers::InputCounter
    end

    it 'raises if given a bad format symbol' do
      expect { issuer.new(:test) }.to raise_exception(SimpleCrawler::Errors::UnknownFormat)
    end
  end
end
