class LocationsController < ApplicationController
  def index
  end

  def nearbys
    locations = Location.near([params['lat'], params['lng']], 4, units: :km)
    render json: { locations: locations }
  end
end
