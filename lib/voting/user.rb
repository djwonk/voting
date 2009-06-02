module Voting
  class User
    include DataMapper::Resource

    property :id,          Serial
    property :name,        String
    property :domain_id,   String
    property :created_at,  DateTime
    property :updated_at,  DateTime

    belongs_to :domain, :class_name => "Voting::Domain", :child_key => [:domain_id]
    has n, :votes,      :class_name => "Voting::Vote",   :child_key => [:user_id]

    validates_present   :name, :domain
    validates_is_unique :name, :scope => :domain_id

    def voted?(election)
      election.votes.first(:user_id => id)
    end
  end
end
