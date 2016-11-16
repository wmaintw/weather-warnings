require 'sinatra'
require 'sinatra/json'
require './parse-warnings.rb'

get '/' do
  'Hello world!'
end

get '/warning' do
  json parse_latest_warning
end

get '/warning-history' do
  json parse_warning_history
end