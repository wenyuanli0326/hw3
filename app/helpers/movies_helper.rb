# frozen_string_literal: true

# the collection of helper functions for the movies
module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end
end
