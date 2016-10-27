# frozen_string_literal: true
require_relative 'skyscanner_api'

module Skyscanner
  # Route info
  class Route
    attr_reader :market, :currency, :locale
    attr_reader :origin, :destination
    attr_reader :outbound, :inbound
    attr_reader :routes

    def initialize(skyscanner_api, data)
      @skyscanner_api = skyscanner_api
      @routes = data[:routes]
      load_env_data(data['market'], data['currency'], data['locale'])
      load_place(data['origin'], data['destination'])
      load_date(data['outbound'], data['inbound'])
    end

    def routes_info
      @routes
    end

    def self.find(skyscanner_api, data)
      data[:routes] = skyscanner_api.routes_info(data)
      new(skyscanner_api, data)
    end

    private

    def load_env_data(market, currency, locale)
      @market = market
      @currency = currency
      @locale = locale
    end

    def load_place(origin, destination)
      @origin = origin
      @destination = destination
    end

    def load_date(outbound, inbound)
      @outbound = outbound
      @inbound = inbound
    end
  end
end
