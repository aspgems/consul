require_dependency Rails.root.join('app', 'models', 'user').to_s

class User
  validates :phone_number, phone: { allow_blank: true, types: [:mobile, :fixed_line] }

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

  def destroy_verification
    update_attributes(document_number: nil, residence_verified_at: nil)
  end
end
