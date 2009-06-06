require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Voting::Vote' do
  before(:each) do
    @vote = Factory.build(:vote)
  end

  specify 'should be valid' do
    @vote.should be_valid
  end

  specify 'should require a value' do
    @vote.value = nil
    @vote.save.should be_false
    @vote.errors.on(:value).should include("Value must not be blank")
  end

  specify 'should require a value within the acceptable range' do
    @vote.value = 1000
    @vote.save.should be_false
    @vote.errors.on(:value).should include("Value must be one of [-1, 1]")
  end

  specify 'should require a user' do
    @vote.user = nil
    @vote.save.should be_false
    @vote.errors.on(:user).should include("User must not be blank")
  end

  specify 'should require a unique user within the election' do
    @vote.save
    @vote = Voting::Vote.new(:value => @vote.value, :candidate => @vote.candidate, :user => @vote.user)
    @vote.save.should be_false
    @vote.errors.on(:user).should include("User has already voted for a candidate in this election")
  end

  specify 'should require a candidate' do
    @vote.candidate = nil
    @vote.save.should be_false
    @vote.errors.on(:candidate).should include("Candidate must not be blank")
  end
end
