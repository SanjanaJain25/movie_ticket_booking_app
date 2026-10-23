class Movie < ApplicationRecord
    has_many :shows, dependent: :restrict_with_error
    has_many :movie_reviews, dependent: :destroy

    validates :title, :genre,:language, presence: true
    validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
    end
