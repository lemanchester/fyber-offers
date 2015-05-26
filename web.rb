require 'sinatra/base'

module Fyber
  class Web < Sinatra::Base

    set :show_exceptions, false

    API_CREDENTIALS = {
        appid: 157,
        api_key: "b07a12df7d52e6c118e5d47d3f9e60135b109a1f",
        device_id: "2b6f0cc904d137be2e1730235f5664094b83"
      }

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
