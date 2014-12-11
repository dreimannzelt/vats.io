require 'rubygems'
require 'sinatra'

require './lib/vat.rb'


#
# ----
#

get '/' do
  erb :index
end

get '/rates/:origin_code/:target_code/:amount' do
  content_type 'application/json', charset: 'utf-8'

  params[:net] ||= "true"
  params[:needs_net] ||= "false"

  is_net    = ( params[:net] == "true" )
  needs_net = ( params[:needs_net] == "true" )

  vat_from  = Vat.from_code( params[:origin_code] )
  vat_to    = Vat.from_code( params[:target_code] )
  amount    = params[:amount].to_f

  net = is_net ?
    (amount) :
    (amount / (100 + vat_from.rate) * 100)

  gross = is_net ?
    (amount * (100 + vat_to.rate) / 100) :
    (amount / (100 + vat_from.rate) * (100 + vat_to.rate))

  amount = needs_net ?
    (net) :
    (gross)

  vat_amount = is_net ?
    (gross - net) :
    (gross - net)

  {
    net: net.round(2),
    gross: gross.round(2),
    amount: amount.round(2),
    vat_amount: vat_amount.round(2),
    vats: {
      from: vat_from,
      to: vat_to
    },
    _parameters: {
      origin_code: params[:origin_code],
      target_code: params[:target_code],
      amount: params[:amount],
      is_net: is_net,
      needs_net: needs_net
    }
  }.to_json
end

get '/rates.json' do
  content_type 'application/json', charset: 'utf-8'
  Vat.rates.to_json
end

get '/rates/:code.json' do
  content_type 'application/json', charset: 'utf-8'
  Vat.rates[ params[:code] ].to_json
end

get '/names.json' do
  content_type 'application/json', charset: 'utf-8'
  Vat.names.to_json
end

get '/names/:locale.json' do
  content_type 'application/json', charset: 'utf-8'
  Vat.names[ params[:locale] ].to_json
end

