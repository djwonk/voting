require "#{File.dirname(__FILE__)}/spec_helper"

module VotingTest
  class Foo; def id; 11; end; end
  class Bar; def id; 12; end; end
end

describe 'Voting::Helpers' do
  include Voting::Helpers::Urls

  context 'url helpers' do
    specify 'should generate a path name' do
      @foo = VotingTest::Foo.new
      @bar = VotingTest::Bar.new
      path_to(@foo, @bar).should == '/foos/11/bars/12'
    end
  end
end
