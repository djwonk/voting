# PURPOSE
# Workflow

class VotingClient
  include HTTParty
end

VotingClient.post "/elections", {
  :title      => title,
  :start_date => start_date,
  :end_date   => end_date
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
VotingClient.post("/elections/#{election_id}/candidates", {
  :name => name
})
# return data:
# * success
# * failure
# * candidate_ide