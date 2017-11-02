require 'csv'
namespace :chiloeches do
  desc "load districts from tmp/distritos-usuarios-decide-chiloeches.csv"
  task load_districts: :environment do
    CSV.foreach('distritos-usuarios-decide-chiloeches.csv', headers: true) do |row|
      user = User.where(document_number: row[1]).first
      user.update_columns(geozone_id: Geozone.where(census_code: row[2]).first.try(:id) ) if user.present?
      Rails.logger.info("#{row[1]} - #{row[2]} - #{user.geozone_id}") if user.present?
    end
  end
end
