# PURPOSE
# Workflow

class VotingClient
  include HTTParty
end

voter_count = 100
candidate_count = 10

VotingClient.post "/elections", {
  :title      => title
})
# returns:
# * success
# * failure
#
# other return data:
# (page content)
# * election_id
# * some sort of authentication
#   - token?
#   - ??? 

# Adding a candidate to the election

voters = []
1.upto(voter_count) do |v|
  voters[v] = {
    :name     => "Voter #{v}"
  }
end

candidates = []
1.upto(candidate_count) do |c|
  name = "Candidate #{c}"
  response = VotingClient.post("/elections/#{election_id}/candidates", {
    :name => name
  })
  candidate_id = parse_response(response)
  candidates[c] = {
    :name         => name,
    :candidate_id => candidate_id
  }
end

# return data:
# * success
# * failure
# * candidate_id

VotingClient.post("/elections", { :start => "now" })

# Voting happens here

voters.each_with_index do |voter, voter_id|
  VotingClient.post("/elections/#{election_id}/votes"), {
    :voter_id     => voter_id
    :candidate_id => (rand * candidate_count) + 1
  })
end

VotingClient.post("/elections", { :end => "now" })
