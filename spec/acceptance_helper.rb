require 'spec_helper'
require 'capybara/rspec'
require 'sinatra/base'

require File.expand_path 'web.rb'

ENV['RACK_ENV'] = 'test'

Capybara.app = Fyber::Web

