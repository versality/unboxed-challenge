require 'spec_helper'

describe TopLanguage do
  context 'without pagination' do
    before(:all) do
      VCR.use_cassette('versality') do
        @top_language = TopLanguage.new('versality')
        @top_language.request
      end
    end

    describe '#language' do
      it 'should return top language' do
        expect(@top_language.language).to eq('Ruby')
      end
    end

    describe '#remaining_queries' do
      it 'should return remaining queries count' do
        expect(@top_language.remaining_queries).to eq(4999)
      end
    end
  end

  context 'with pagination' do
    before(:all) do
      VCR.use_cassette('andrew') do
        @top_language = TopLanguage.new('andrew')
        @top_language.request
      end
    end

    describe '#language' do
      it 'should return top language' do
        expect(@top_language.language).to eq('JavaScript')
      end
    end

    describe '#remaining_queries' do
      it 'should return remaining queries count' do
        expect(@top_language.remaining_queries).to eq(4999)
      end
    end
  end
end
