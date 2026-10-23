
class AdminManager
  def initialize(user)
    @user = user
  end

  
  # Movie Management
  

  def add_movie(attributes)
    authorize_admin!
    Movie.create!(attributes)
  end

  def update_movie(id, attributes)
    authorize_admin!
    Movie.find(id).update!(attributes)
  end

  def delete_movie(id)
    authorize_admin!
    Movie.find(id).destroy!
  end

  def list_movies
    authorize_admin!
    Movie.all
  end

  
  # Cinema Management
  

  def add_cinema(attributes)
    authorize_admin!
    Cinema.create!(attributes)
  end

  def update_cinema(id, attributes)
    authorize_admin!
    Cinema.find(id).update!(attributes)
  end

  def list_cinemas
    authorize_admin!
    Cinema.all
  end

  
  # Screen Management
  

  def add_screen(cinema_id, attributes)
    authorize_admin!

    cinema = Cinema.find(cinema_id)
    cinema.screens.create!(attributes)
  end

  def list_screens(cinema_id)
    authorize_admin!

    cinema = Cinema.find(cinema_id)
    cinema.screens
  end

  
  # Seat Management
  

  def add_seat(screen_id, row_label, seat_number)
    authorize_admin!

    screen = Screen.find(screen_id)

    screen.seats.create!(
      row_label: row_label,
      seat_number: seat_number
    )
  end

  def list_seats(screen_id)
    authorize_admin!

    screen = Screen.find(screen_id)
    screen.seats
  end

  
  # Show Management
  

  def add_show(attributes)
    authorize_admin!
    Show.create!(attributes)
  end

  def update_show(id, attributes)
    authorize_admin!
    Show.find(id).update!(attributes)
  end

  def list_shows
    authorize_admin!
    Show.includes(:movie, :screen)
  end

  
  # Booking Monitoring
  

  def list_bookings
    authorize_admin!
    Booking.includes(:user, :booking_seats)
  end

  def booking_details(id)
    authorize_admin!

    Booking.includes(:user, :booking_seats, :seat_reservations)
           .find(id)
  end

  
  # Review Monitoring
  

  def list_movie_reviews
    authorize_admin!
    MovieReview.all
  end

  def list_cinema_reviews
    authorize_admin!
    CinemaReview.all
  end

  
  # Authorization
  

  private

  def authorize_admin!
    unless @user&.admin?
      raise StandardError,
            "Unauthorized: Only admins can perform this action."
    end
  end
end
