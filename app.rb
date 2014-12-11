require 'rubygems'
require 'sinatra'

Dir.glob("./lib/*.rb").each { |f| require f }


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

  conversion = Conversion.new(
    params[:origin_code],
    params[:target_code],
    params[:amount],
    {is_net: is_net, needs_net: needs_net}
  )

  {
    net: conversion.net,
    gross: conversion.gross,
    amount: conversion.amount,
    vat_amount: conversion.vat_amount,
    vats: {
      from: conversion.from,
      to: conversion.to
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

