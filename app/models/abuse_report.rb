class AbuseReport < ApplicationRecord
  belongs_to :article
  validates :reason, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }
end
