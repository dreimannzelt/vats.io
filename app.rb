require 'rubygems'
require 'sinatra'
require 'json'

data_root = "data"
rates_file_path = File.join data_root, "rates.json"
names_file_path = File.join data_root, "names.json"


get '/' do
  erb :index
end

get '/rates.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(rates_file_path) ).to_json
end

get '/rates/:locale.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(rates_file_path) )[params[:locale]].to_json
end

get '/names.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(names_file_path) ).to_json
end

get '/names/:locale.json' do
  content_type 'application/json', charset: 'utf-8'
  JSON.parse( File.read(names_file_path) )[params[:locale]].to_json
end

