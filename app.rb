require 'sinatra'

get '/names.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(settings.root + "/names.json") ).to_json
end

get '/names/:locale.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(settings.root + "/names.json") )[params[:locale]].to_json
end

get '/rates.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(settings.root + "/rates.json") ).to_json
end

get '/rates/:locale.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(settings.root + "/rates.json") )[params[:locale]].to_json
end
