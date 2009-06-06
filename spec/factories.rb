require 'factory_girl'

Factory.define :domain, :class => Voting::Domain do |f|
  f.name 'zerosum.org'
end

Factory.define :user, :class => Voting::User do |f|
  f.name 'user'
  f.domain { |a| a.association(:domain) }
end

Factory.define :election, :class => Voting::Election do |f|
  f.name 'election'
end

Factory.define :candidate_a, :class => Voting::Candidate do |f|
  f.name 'foo'
  f.election { |a| a.association(:election) }
end

Factory.define :candidate_b, :class => Voting::Candidate do |f|
  f.name 'bar'
  f.election { |a| a.association(:election) }
end

Factory.define :vote, :class => Voting::Vote do |f|
  f.user { |a| a.association(:user) }
  f.candidate { |a| a.association(:candidate_a) }
  f.value 1
end
