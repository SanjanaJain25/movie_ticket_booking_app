class MovieCatalog
  def list_movies
    Movie.all
  end

  def search_movies(title)
    return Movie.none if title.blank?

    Movie.where("title LIKE ?", "%#{title}%")
  end

  def filter_movies(genre: nil, language: nil)
    movies = Movie.all
    movies = movies.where(genre: genre) if genre.present?
    movies = movies.where(language: language) if language.present?
    movies
  end

def list_shows(movie_id: nil)
  shows = Show.includes(:movie, screen: :cinema)
  shows = shows.where(movie_id: movie_id) if movie_id.present?

  shows.order(:starts_at).map do |show|
    {
      show_id: show.id,
      movie: show.movie.title,
      cinema: show.screen.cinema.name,
      screen: show.screen.name,
      starts_at: show.starts_at,
      ends_at: show.ends_at,
      ticket_price: show.ticket_price.to_f
    }
  end
end

  def available_seats(show_id)
    show = Show.find(show_id)

    reserved_seat_ids = show.seat_reservations
                             .joins(:booking)
                             .where(bookings: { status: %w[pending confirmed] })
                             .select(:seat_id)

    Seat.where(screen_id: show.screen_id)
        .where.not(id: reserved_seat_ids)
        .order(:row_label, :seat_number)
  end
end