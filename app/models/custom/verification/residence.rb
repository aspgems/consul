
require_dependency Rails.root.join('app', 'models', 'verification', 'residence').to_s

class Verification::Residence

  # Validations
  validate :postal_code_in_city

  # Callbacks
  before_validation :set_terms_of_service # HACK

  def postal_code_in_city
    errors.add(:postal_code, I18n.t('verification.residence.new.error_not_allowed_postal_code')) unless valid_postal_code?
  end

  def allowed_age
    return if errors[:date_of_birth].any?
    errors.add(:date_of_birth, I18n.t('verification.residence.new.error_not_allowed_age')) unless date_of_birth <= 16.years.ago
  end

  def geozone
    # Nothing to do
  end

  def gender
    # Nothing to do
  end

  private
    def retrieve_census_data
      # Nothing to do
    end

    def residency_valid?
      true
    end

    def set_terms_of_service
      self.terms_of_service = "1"
    end

    def valid_postal_code?
      %w(00001 00002 00003 00004 00005 00009).include?(postal_code)
    end

    def call_census_api
      # Nothing to do
      true
    end
end
