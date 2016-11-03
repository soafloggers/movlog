# frozen_string_literal: true

module Movlog
  # Executable code for file(s) in bin/ folder
  class Runner
    def self.run!(args)
      omdb_keyword = ARGV[0]
      unless omdb_keyword
        puts 'USAGE: movlog [omdb_keyword]'
        exit(1)
      end

      movie = Movlog::Movie.find(t: omdb_keyword)

      puts "#{movie.title} (#{movie.year})"
      puts "Actors: #{movie.actors}"
      puts "Plot: #{movie.plot}"
    end
  end
end
