class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :url_must_be_valid

  encrypts :username, deterministic: true
  encrypts :password

  scope :search_name, ->(name) {
    where("entries.name ILIKE ?", "%#{sanitize_sql_like(name)}%") if name.present?
  }

  def self.search(name)
    search_name(name).order(:name)
  end

  private

  # Example of custom validator, not necessarily what to use
  def url_must_be_valid
    return if url.blank?
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
