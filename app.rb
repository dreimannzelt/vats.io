require 'rubygems'
require 'sinatra'
require 'geocoder'

Dir.glob("./lib/*.rb").each { |f| require f }

enable :sessions

#
# ----
#

before '/' do
  @country_code = session[:country_code] ||= begin
    Geocoder.search( request.ip ).first.country_code
  rescue
    "DE"
  end

  @country_code.downcase!
end

before %r{/(rates|names)/*} do
  content_type 'application/json', charset: 'utf-8'
end

#
# ---
#

get '/' do
  @vats = Vat.rates

  erb :index
end

get '/rates/:origin_code/:target_code/:amount' do
  params[:net] ||= "true"
  params[:needs_net] ||= "false"
  is_net    = ( params[:net] == "true" )
  needs_net = ( params[:needs_net] == "true" )

  conversion = Conversion.new(
    params[:origin_code],
    params[:target_code],
    params[:amount],
    {is_net: is_net, needs_net: needs_net}
  )

  conversion.as_json.merge({
    _parameters: {
      origin_code: params[:origin_code],
      target_code: params[:target_code],
      amount: params[:amount],
      is_net: is_net,
      needs_net: needs_net
    }
  }).to_json
end

get '/rates.json' do
  Vat.rates.to_json
end

get '/rates/:code.json' do
  Vat.rates[ params[:code] ].to_json
end

get '/names.json' do
  Vat.names.to_json
end

get '/names/:locale.json' do
  Vat.names[ params[:locale] ].to_json
end

