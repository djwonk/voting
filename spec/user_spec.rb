require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Voting::User' do
  before(:each) do
    @domain = Factory(:domain)
    @user = Factory.build(:user)
  end

  specify 'should be valid' do
    @user.should be_valid
  end

  specify 'should require a domain' do
    @user.domain = nil
    @user.save.should be_false
    @user.errors[:domain].should include("Domain must not be blank")
  end

  specify 'should require a name' do
    @user = Voting::User.new
    @user.save.should be_false
    @user.errors[:name].should include("Name must not be blank")
  end

  specify 'should require a unique name within the domain' do
    @user.save
    @user = Voting::User.new(:name => 'user', :domain => @user.domain)
    @user.save.should be_false
    @user.errors[:name].should include("Name is already taken")
  end
end
