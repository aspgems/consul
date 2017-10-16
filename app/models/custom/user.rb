require_dependency Rails.root.join('app', 'models', 'user').to_s
require 'csv'

class User
  validates :phone_number, phone: { allow_blank: true, types: [:mobile, :fixed_line] }

  scope :sort_by_newest, -> { order(created_at: :desc) }
  scope :unverified, -> { where(verified_at: nil).where.not(document_number: nil) }
  scope :search_by_email_username_document, lambda {|term|
    where("email = ? OR username ILIKE ? OR document_number ILIKE ?",
          term, "%#{term}%", "%#{term}%")
  }

  delegate :name, to: :geozone, prefix: true, allow_nil: true

  def self.search_unverified(term)
    term.present? ? search_by_email_username_document(term) : all
  end

  def level_two_verified?
    level_three_verified?
  end

  def pending_verification?
    unverified? && document_number.present?
  end

  def self.to_csv
    attributes = %w{username email document_number document_type phone_number gender geozone_name date_of_birth verified_at created_at}

    CSV.generate do |csv|
      csv << attributes
      all.find_each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def destroy_verification
    update_attributes(document_number: nil, residence_verified_at: nil)
  end
end
