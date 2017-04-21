require_dependency Rails.root.join('app', 'models', 'user').to_s
require 'csv'

class User
  validates :phone_number, phone: { allow_blank: true, types: [:mobile, :fixed_line] }

  scope :sort_by_newest, -> { order(created_at: :desc) }
  scope :unverified, -> { where(verified_at: nil).where.not(document_number: nil) }
  scope :search_by_email_username_document, ->(term) { where("email = ? OR username ILIKE ? OR document_number ILIKE ?", term, "%#{term}%", "%#{term}%") }

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
    attributes = %w{username email document_number document_type phone_number gender date_of_birth verified_at created_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end
end
