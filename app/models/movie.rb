# frozen_string_literal: true

class Movie < ActiveRecord::Base
  #    def self.with_director(director)
  #        return Movie.where("director: (?)", director)
  #    end

  def self.search_movies_by_director(id)
    movie = Movie.find(id)
    director = movie.director
    return nil if director.blank? || director.nil?

    Movie.where(director:).where.not(title: movie.title)
  end
end
