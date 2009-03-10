class Candidate
  include DataMapper::Resource

  property :id,          Serial
  property :election_id, Integer
  property :name,        String  
  property :created_at,  DateTime
  property :updated_at,  DateTime

  validates_present :name

  belongs_to :election
end
