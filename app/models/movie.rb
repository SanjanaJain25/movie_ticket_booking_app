class Movie < ApplicationRecord
    has_many :shows, dependent: :restrict_with_error
    has_many :movie_reviews, dependent: :destroy

    validates :title, :genre,:language, presence: true
    validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :Movie_release_date_cannot_be_in_the_future

    private
    def Movie_release_date_cannot_be_in_the_future
        if release_date.present? && release_date > Date.today
            errors.add(:release_date, "can't be in the future")
        end
    end
end
