# frozen_string_literal: true

require 'bundler/setup'
require './app.rb'

map '/dist' do
  run Rack::Directory.new('./public/dist')
end

run Sinatra::Application
