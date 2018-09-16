describe 'TopLanguageController' do
  describe "GET '/'" do
    it 'should render page' do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/versality'" do
    it 'should render page' do
      VCR.use_cassette('versality') do
        get '/versality'
      end

      expect(last_response.status).to eq(200)
    end
  end
end
