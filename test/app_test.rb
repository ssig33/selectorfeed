# frozen_string_literal: true

require_relative 'test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Generate Feed from CSS Selector'
  end

  def test_feed_with_empty_params
    get '/feed'
    assert_equal 302, last_response.status
  end

  def test_feed_with_valid_params
    html_response = <<~HTML
      <!DOCTYPE html>
      <html>
      <head><title>Test Site</title></head>
      <body>
        <li><h2><a href="/article1">Article 1</a></h2></li>
        <li><h2><a href="/article2">Article 2</a></h2></li>
      </body>
      </html>
    HTML

    stub_request(:get, 'https://example.com/test')
      .to_return(status: 200, body: html_response, headers: { 'Content-Type' => 'text/html' })

    get '/feed', url: 'https://example.com/test', list: 'li h2 a'
    
    assert_equal 200, last_response.status
    assert_equal 'application/xml;charset=utf-8', last_response.content_type
    assert_includes last_response.body, 'Test Site'
    assert_includes last_response.body, 'Article 1'
    assert_includes last_response.body, 'Article 2'
  end

  def test_feed_with_no_articles_found
    html_response = <<~HTML
      <!DOCTYPE html>
      <html>
      <head><title>Empty Site</title></head>
      <body>
        <p>No articles here</p>
      </body>
      </html>
    HTML

    stub_request(:get, 'https://example.com/empty')
      .to_return(status: 200, body: html_response, headers: { 'Content-Type' => 'text/html' })

    get '/feed', url: 'https://example.com/empty', list: 'li h2 a'
    
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Items not found'
  end
end