class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
end
