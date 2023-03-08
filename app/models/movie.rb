class Movie < ActiveRecord::Base
    
#    def self.with_director(director)
#        return Movie.where("director: (?)", director)
#    end

    def self.search_movies_by_director(id)
        movie = Movie.find(id)
        director = movie.director
        if director.blank? or director.nil?
            return nil 
        else
            return Movie.where(director: director).where.not(title: movie.title)
        end
    end
  
  
  
end
