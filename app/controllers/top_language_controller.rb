get '/' do
  'Please use the following url /:github_username'
end

get '/:username' do
  top_language = TopLanguage.new(params['username'])
  top_language.request
  erb :index, locals: { top_language: top_language }, layout: :application
end
