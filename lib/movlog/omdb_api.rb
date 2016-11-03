#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# frozen_string_literal: true
require 'http'
require 'json'

module Movlog
  # Service for all OMDB API calls
  class OmdbApi
    OMDB_URL = 'http://www.omdbapi.com/'

    def self.movie_info(t)
      movie_response = HTTP.get(
        OMDB_URL,
        params: {
          t: t,
          y: '',
          plot: 'short',
          r: 'json'
        }
      )
      JSON.load(movie_response.to_s)
    end

    def self.location(movie_id)
      
      page_url = "http://www.imdb.com/title/#{movie_id}/locations?ref_=tt_dt_dt"

      # Fetch and parse HTML document
      location_arr = []

      doc = Nokogiri::HTML(open(page_url))

      doc.search('//div[@class="soda sodavote odd"]/dt/a').each { |link| location_arr << link.content}

      doc.search('//div[@class="soda sodavote even"]/dt/a').each { |link| location_arr <<  link.content}

      location_arr.to_json
    end
  end
end
