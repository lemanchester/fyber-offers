require 'sinatra/base'

module Fyber
  class Web < Sinatra::Base

    get '/' do
      erb :index
    end

  end
end
