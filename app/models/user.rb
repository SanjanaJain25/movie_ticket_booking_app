class User < ApplicationRecord
    ROLES = %w[admin customer].freeze

    has_secure_password


    has_many :bookings, dependent: :restrict_with_error
    has_many :movie_reviews, dependent: :destroy
    has_many :cinema_reviews, dependent: :destroy
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :role, presence: true, inclusion: { in: ROLES}

    normalizes :email, with: ->(email) { email.strip.downcase }

   def self.register(name:, email:, password:)
    user = new(
      name: name,
      email: email,
      password: password,
      role: "customer"
    )

    user.save
    user
  end


    def admin?
        role == "admin"
    end

    def customer?
        role == "customer"
    end

def booking_history
  if admin?
    Booking.all
  else
    bookings
  end
end
end
