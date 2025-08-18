# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'
require 'webmock/minitest'

ENV['RACK_ENV'] = 'test'

require_relative '../app'

WebMock.disable_net_connect!(allow_localhost: true)