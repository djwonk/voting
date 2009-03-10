require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Vote' do
  before(:each) do
    @election = Vote.new
  end

  specify 'should be valid' do
    @election.should be_valid
  end
end
