require "#{File.dirname(__FILE__)}/spec_helper"

describe 'Voting::Election' do
  before(:each) do
    @election = Factory.build(:election)
  end

  specify 'should be valid' do
    @election.should be_valid
  end

  specify 'should require a name' do
    @election.name = nil
    @election.save.should be_false
    @election.errors[:name].should include("Name must not be blank")
  end

  specify 'should start in the pre state' do
    @election.save
    @election.status.should == 'pre'
  end

  context 'state transitions' do
    before(:each) do
      @election.save
    end

    specify 'should open the election for voting' do
      @election.open_election!.should be_true
      @election.status.should == 'open'
    end

    specify 'should cancel the election from the pre state' do
      @election.cancel_election!.should be_true
      @election.status.should == 'canceled'
    end

    specify 'should cancel the election from the open state' do
      @election.open_election!
      @election.cancel_election!.should be_true
      @election.status.should == 'canceled'
    end

    specify 'should close the election and calculate the winner' do
      @election.open_election!
      @election.should_receive(:winner)
      @election.close_election!.should be_true
      @election.status.should == 'closed'
    end
  end

  specify 'should report user voting status' do
    @election.save
    @vote = Factory(:vote, :election_id => @election.id)
    @user = @vote.user
    @election.voted?(@user).should == @vote
    @election.voted?(mock('User', :id => 1000)).should be_nil
  end
end
