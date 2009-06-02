require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  specify 'should show the default index page' do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Main Page/)
  end

  specify 'should have more specs' do
    pending
  end
end
