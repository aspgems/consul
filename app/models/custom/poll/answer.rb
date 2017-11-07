require_dependency Rails.root.join('app', 'models', 'poll', 'answer').to_s

class Poll::Answer < ActiveRecord::Base

  def record_voter_participation
    Poll::Voter.find_or_create_by(user: author, poll: poll)
  end

end