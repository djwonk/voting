module Voting 
  class Election
    include DataMapper::Resource

    property :id,         Serial
    property :name,       String  
    property :created_at, DateTime
    property :updated_at, DateTime

    has n, :candidates, :class_name => "Voting::Candidate", :child_key => [:election_id]
    has n, :votes,      :class_name => "Voting::Vote",      :child_key => [:election_id]

    validates_present :name

    is :state_machine, :initial => :pre, :column => :status do
      state :pre
      state :open
      state :closed, :enter => :winner
      state :cancelled

      event :open_election do
        transition :from => :pre,  :to => :open
      end

      event :close_election do
        transition :from => :open, :to => :closed
      end

      event :cancel_election do
        transition :from => :pre,  :to => :cancelled
        transition :from => :open, :to => :cancelled
      end
    end

    def voted?(user)
      votes.first(:user_id => user.id)
    end

    def winner
      # do something
    end
  end
end
