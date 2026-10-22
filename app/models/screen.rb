class Screen < ApplicationRecord
  belongs_to :cinema

  has_many :seats, dependent: :restrict_with_error
  has_many :shows, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { scope: :cinema_id, message: "Screen name must be unique within the same cinema" }
end
