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
          type: 'movie',
          r: 'json'
        }
      )
      JSON.parse(movie_response.to_s)
    end

    def self.search_movie(s)
      movie_response = HTTP.get(
        OMDB_URL,
        params: {
          s: s,
          type: 'movie',
          r: 'json'
        }
      )
      JSON.parse(movie_response.to_s)
    end

    def self.location(movie_id)
      location_arr = []
      doc = Nokogiri::HTML(open(location_url(movie_id)))
      doc.search('//div[@class="soda sodavote odd"]/dt/a').each { |link| location_arr << link.content.gsub(/\n/, '') }
      doc.search('//div[@class="soda sodavote even"]/dt/a').each { |link| location_arr <<  link.content.gsub(/\n/, '') }
      JSON.parse(location_arr.to_json)
    end

    private_class_method

    def self.location_url(imdb_id)
       "http://www.imdb.com/title/#{imdb_id}/locations?ref_=tt_dt_dt"
    end
  end
end
