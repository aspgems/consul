require_dependency Rails.root.join('app', 'models', 'proposal').to_s

class Proposal < ActiveRecord::Base

  def votable_by?(user)
    user && user.level_two_or_three_verified? && (!geozone_id.present? || geozone_id == user.geozone_id)
  end

end

