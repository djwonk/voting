module Voting
  class Domain
    include DataMapper::Resource

    property :id,          Serial
    property :name,        String
    property :created_at,  DateTime
    property :updated_at,  DateTime

    has n, :users, :class_name => "Voting::User", :child_key => [:domain_id]

    validates_present   :name
    validates_is_unique :name
  end
end
