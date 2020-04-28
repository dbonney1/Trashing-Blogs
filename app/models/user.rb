class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_one :profile, dependent: :destroy
    
    has_many :active_subscriptions, class_name: "Subscription", foreign_key: "subscriber_id", dependent: :destroy
    has_many :passive_subscriptions, class_name: "Subscription", foreign_key: "subscribed_id", dependent: :destroy
    has_many :subscribed_to, through: :active_subscriptions, source: :subscribed 
    has_many :subscribers, through: :passive_subscriptions, source: :subscriber
    
    # subscribe helper methods
    # subscribe to a user
    def subscribe(other_user)
        active_subscriptions.create(subscribed_id: other_user.id)
    end
    
    # unsubscribe to a user
    def unsubscribe(other_user)
        active_subscriptions.find_by(subscribed_id: other_user.id).destroy
    end
    
    # check to see if user is following a certain user
    def subscribed_to?(other_user)
        subscribed_to.include?(other_user)
    end
    

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    before_save { self.email = email.downcase }
    
    validates :name,
        presence: true,
        length: { maximum: 12 }
    
    validates :email,
        presence: true,
        length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
        
    validates :password,
        presence: true,
        length: { minimum: 6 }
        
    has_secure_password
end
