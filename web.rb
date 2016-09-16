require 'sinatra/base'

module Fyber
  class Web < Sinatra::Base

    set :show_exceptions, false

    API_CREDENTIALS = {
        appid: ENV['APP_ID'],
        api_key: ENV['API_KEY'],
        device_id: ENV['DEVICE_ID']
    }.freeze

    get '/' do
      erb :index
    end

    get '/offers/' do
      client = Fyber::Client.new(API_CREDENTIALS)

      default = {
        locale: "de",
        ip: "109.235.143.113",
        offer_types: "112"
      }
      offers = client.offers(default.merge(params))
      erb :offers, :locals => { 'offers' => offers }
    end

    error do
      erb :error, :locals => { 'error' => env['sinatra.error'] }
    end

  end
end
