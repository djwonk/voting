module Voting
  class Vote
    include DataMapper::Resource

    property :id,           Serial
    property :type,         Discriminator
    property :value,        Integer
    property :candidate_id, Integer
    property :user_id,      Integer
    property :created_at,   DateTime
    property :updated_at,   DateTime

    belongs_to :user,      :class_name => "Voting::User",      :child_key => [:user_id]
    belongs_to :candidate, :class_name => "Voting::Candidate", :child_key => [:candidate_id]
    belongs_to :election,  :through => :candidate

    validates_present   :value, :user, :candidate
    validates_within    :value, :set => [-1, 1]

    validates_with_method :user, :method => :verify_unique

    private

    def verify_unique
      # TODO: implement option on election to prevent vote overwriting?
      if candidate && user && Voting::Vote.first(:user_id => user_id, :candidate_id => candidate_id)
        [false, "User has already voted for a candidate in this election"]
      else
        true
      end
    end
  end
end
