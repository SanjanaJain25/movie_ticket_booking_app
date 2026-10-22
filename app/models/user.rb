class User < ApplicationRecord
    has_many :bookings, dependent: :restrict_with_error
    has_many :movie_reviews, dependent: :destroy
    has_many :cinema_reviews, dependent: :destroy
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
end
