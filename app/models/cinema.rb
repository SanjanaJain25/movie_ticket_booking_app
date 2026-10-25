class Cinema < ApplicationRecord
     include AdminCreatedRecord

    has_many :screens, dependent: :restrict_with_error
    has_many :cinema_reviews, dependent: :destroy

    validates :name, :location, presence: true
end
