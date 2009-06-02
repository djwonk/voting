module Voting
  class Candidate
    include DataMapper::Resource

    property :id,          Serial
    property :name,        String  
    property :election_id, Integer
    property :created_at,  DateTime
    property :updated_at,  DateTime

    belongs_to :election, :class_name => "Voting::Election", :child_key => [:election_id]

    validates_present :name, :election
    validates_is_unique :name, :scope => :election_id
  end
end
