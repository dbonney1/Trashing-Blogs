class Article < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :abuse_reports, dependent: :destroy
    acts_as_taggable_on :tags
    
    validates :title, presence: true, length: { minimum: 5 }
    validates :text, presence: true, length: { minimum: 10 }
end
