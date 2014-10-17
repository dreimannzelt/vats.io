require 'sinatra'

get '/names.json' do
  content_type :json
  File.read(settings.root + "/names.json")
end

get '/rates.json' do
  content_type :json
  File.read(settings.root + "/rates.json")
end
